//
//  BLEConnection.swift
//  BaristaBrosiOS
//
//  Created by Tyler Duic on 4/19/21.
//

import UIKit
import CoreBluetooth

class BLEConnection: NSObject {

    let uuidHM10Service = CBUUID(string: "0000ffe0-0000-1000-8000-00805f9b34fb")
    let uuidHM10Char = CBUUID(string: "0000ffe1-0000-1000-8000-00805f9b34fb")

    var bleCentral: CBCentralManager!
    var connectedPeripheral: CBPeripheral?
    
    var readValue: String = ""
    
    enum BLELifecycleState: String {
        case bluetoothNotReady
        case disconnected
        case scanning
        case connecting
        case connectedDiscovering
        case connected
    }
    
    var lifecycleState = BLELifecycleState.bluetoothNotReady {
        didSet {
            guard lifecycleState != oldValue else { return }
            print("state = \(lifecycleState)")
        }
    }
}

extension BLEConnection {
    func initBLE() {
        bleCentral = CBCentralManager(delegate: self, queue: nil)
    }
    
    func bleRestartLifecycle() {
        if bleCentral.state == .poweredOn {
            bleScan()
        } else {
            connectedPeripheral = nil
            lifecycleState = .bluetoothNotReady
            return
        }
    }
    
    func bleScan() {
        lifecycleState = .scanning
        bleCentral.scanForPeripherals(withServices: [uuidHM10Service], options: nil)
    }

    func bleConnect(to peripheral: CBPeripheral) {
        connectedPeripheral = peripheral
        lifecycleState = .connecting
        bleCentral.connect(peripheral, options: nil)
    }

    func bleDisconnect() {
        if bleCentral.isScanning {
            bleCentral.stopScan()
        }
        if let peripheral = connectedPeripheral {
            bleCentral.cancelPeripheralConnection(peripheral)
        }
        lifecycleState = .disconnected
    }
    
    func bleWriteCharacteristic(uuid: CBUUID, data: Data) {
        guard let characteristic = getCharacteristic(uuid: uuid) else {
            print("ERROR: write failed, characteristic unavailable, uuid = \(uuid.uuidString)")
            return
        }
        connectedPeripheral?.writeValue(data, for: characteristic, type: .withoutResponse)
    }
    
    func bleReadCharacteristic(uuid: CBUUID) {
            guard let characteristic = getCharacteristic(uuid: uuid) else {
                print("ERROR: read failed, characteristic unavailable, uuid = \(uuid.uuidString)")
                return
            }
            connectedPeripheral?.readValue(for: characteristic)
        }

    func getCharacteristic(uuid: CBUUID) -> CBCharacteristic? {
        guard let service = connectedPeripheral?.services?.first(where: { $0.uuid == uuidHM10Service }) else {
            return nil
        }
        return service.characteristics?.first { $0.uuid == uuid }
    }
    
    private func bleGetStatusString() -> String {
        guard let bleCentral = bleCentral else { return "not initialized" }
        switch bleCentral.state {
        case .unauthorized:
            return bleCentral.state.stringValue + " (allow in Settings)"
        case .poweredOff:
            return "Bluetooth OFF"
        case .poweredOn:
            return "ON, \(lifecycleState)"
        default:
            return bleCentral.state.stringValue
        }
    }
}

extension BLEConnection: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("central didUpdateState: \(central.state.stringValue)")
        bleRestartLifecycle()
    }
    
    func centralManager(_ central: CBCentralManager,
                          didDiscover peripheral: CBPeripheral,
                          advertisementData: [String: Any],
                          rssi RSSI: NSNumber) {
        print("didDiscover {name = \(peripheral.name ?? String("nil"))}")

        guard connectedPeripheral == nil else {
            print("didDiscover ignored (connectedPeripheral already set)")
            return
        }

        bleCentral.stopScan()
        bleConnect(to: peripheral)
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("didConnect")

        lifecycleState = .connectedDiscovering
        peripheral.delegate = self
        peripheral.discoverServices([uuidHM10Service])
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        if peripheral === connectedPeripheral {
            print("didFailToConnect")
            connectedPeripheral = nil
            bleRestartLifecycle()
        } else {
            print("didFailToConnect, unknown peripheral, ingoring")
        }
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if peripheral === connectedPeripheral {
            print("didDisconnect")
            connectedPeripheral = nil
            bleRestartLifecycle()
        } else {
            print("didDisconnect, unknown peripheral, ingoring")
        }
    }
}

extension BLEConnection: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
            guard let service = peripheral.services?.first(where: { $0.uuid == uuidHM10Service }) else {
                print("ERROR: didDiscoverServices, service NOT found\nerror = \(String(describing: error)), disconnecting")
                bleCentral.cancelPeripheralConnection(peripheral)
                return
            }

            print("didDiscoverServices, service found")
            peripheral.discoverCharacteristics([uuidHM10Char], for: service)
        }

        func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
            print("didModifyServices")
            // usually this method is called when Android application is terminated
            if invalidatedServices.first(where: { $0.uuid == uuidHM10Service }) != nil {
                print("disconnecting because peripheral removed the required service")
                bleCentral.cancelPeripheralConnection(peripheral)
            }
        }

        func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
            print("didDiscoverCharacteristics \(error == nil ? "OK" : "error: \(String(describing: error))")")

            if let charHM10 = service.characteristics?.first(where: { $0.uuid == uuidHM10Char }) {
                peripheral.setNotifyValue(true, for: charHM10)
            } else {
                print("HM10 characteristic not found")
                lifecycleState = .connected
            }
        }

        func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
            guard error == nil else {
                print("didUpdateValue error: \(String(describing: error))")
                return
            }

            let data = characteristic.value ?? Data()
            let stringValue = String(data: data, encoding: .utf8) ?? ""
            print("didUpdateValue '\(stringValue)'")
            readValue = stringValue
        }

        func peripheral(_ peripheral: CBPeripheral,
                        didWriteValueFor characteristic: CBCharacteristic,
                        error: Error?) {
            print("didWrite \(error == nil ? "OK" : "error: \(String(describing: error))")")
        }

        func peripheral(_ peripheral: CBPeripheral,
                        didUpdateNotificationStateFor characteristic: CBCharacteristic,
                        error: Error?) {
            guard error == nil else {
                print("didUpdateNotificationState error\n\(String(describing: error))")
                lifecycleState = .connected
                return
            }

            if characteristic.uuid == uuidHM10Char {
                let info = characteristic.isNotifying ? "Subscribed" : "Not subscribed"
//                labelSubscription.text = info
                print(info)
            }
            lifecycleState = .connected
        }
}

extension CBManagerState {
    var stringValue: String {
        switch self {
        case .unknown: return "unknown"
        case .resetting: return "resetting"
        case .unsupported: return "unsupported"
        case .unauthorized: return "unauthorized"
        case .poweredOff: return "poweredOff"
        case .poweredOn: return "poweredOn"
        @unknown default: return "\(rawValue)"
        }
    }
}
