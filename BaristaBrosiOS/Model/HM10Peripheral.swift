//
//  ParticlePeripheral.swift
//  BaristaBrosiOS
//
//  Created by Tyler Duic on 4/6/21.
//

import UIKit
import CoreBluetooth

protocol BluetoothManagerDelegate: AnyObject {
    func peripheralsDidUpdate()
}

protocol BluetoothManager {
    var peripherals: Dictionary<UUID, CBPeripheral> { get }
    var delegate: BluetoothManagerDelegate? { get set }
    func startAdvertising(with name: String)
    func startScanning()
}

protocol HM10Delegate {
    
}

class HM10Peripheral: NSObject {
    
    public static let HM10ServiceUUID = CBUUID(string: "666db5b1-e70f-1b37-e23c-fd9d444d7f83")
    public static let primaryServiceUUID = CBUUID(string: "ffe0")
    public static let secondaryServiceUUID = CBUUID(string: "ffe1")
    
//    var peripheralManager: CBPeripheralManager!
//
//    func startPeripheralManager() {
//        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
//    }
//
//    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
//        guard peripheral.state == .poweredOn else { return }
//        // Start advertising this device as a peripheral
//
//        // Create and configure our characteristic
//        let characteristic = CBMutableCharacteristic(type: primaryServiceUUID,
//                                  properties: [.write, .notify],
//                                  value: nil,
//                                  permissions: .writeable)
//        let characteristic2 = CBMutableCharacteristic(type: secondaryServiceUUID,
//                                  properties: [.write, .notify],
//                                  value: nil,
//                                  permissions: .writeable)
//
//        let service = CBMutableService(type: HM10ServiceUUID, primary: true)
//        service.characteristics = [characteristic, characteristic2]
//
//        // Register this service to our peripheral manager
//        peripheralManager.add(service)
//
//        // Begin advertising, explicitly requesting it includes
//        // our registered service via its identifier
//        peripheralManager.startAdvertising(
//                    [CBAdvertisementDataServiceUUIDsKey: [service],
//                     CBAdvertisementDataLocalNameKey: "Device Information"])
//    }
}

//class BLEConnection: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
//
//    var centralManager: CBCentralManager!
//    var myPeripheral: CBPeripheral!
//
//    func startCentralManager() {
//        self.centralManager = CBCentralManager(delegate: self, queue: nil)
//        print("Central Manager State: \(self.centralManager.state)")
//    }
//
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        switch (central.state) {
//           case .unsupported:
//            print("BLE is Unsupported")
//            break
//           case .unauthorized:
//            print("BLE is Unauthorized")
//            break
//           case .unknown:
//            print("BLE is Unknown")
//            break
//           case .resetting:
//            print("BLE is Resetting")
//            break
//           case .poweredOff:
//            print("BLE is Powered Off")
//            break
//           case .poweredOn:
//            print("BLE is Powered ON")
//            print(central.scanForPeripherals(withServices: [HM10Peripheral.HM10ServiceUUID, HM10Peripheral.primaryServiceUUID, HM10Peripheral.secondaryServiceUUID], options: nil))
//            print(central.isScanning)
//            break
//        @unknown default:
//            break
//        }
//    }
//}

class BLEConnection: NSObject, BluetoothManager {
    // MARK: - Public properties
    weak var delegate: BluetoothManagerDelegate?
    private(set) var peripherals = Dictionary<UUID, CBPeripheral>() {
        didSet {
            delegate?.peripheralsDidUpdate()
        }
    }

    // MARK: - Public methods
    func startAdvertising(with name: String) {
        self.name = name
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }

    func startScanning() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    // MARK: - Private properties
    private var peripheralManager: CBPeripheralManager?
    private var centralManager: CBCentralManager?
    private var name: String?
}

extension BLEConnection: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            if peripheral.isAdvertising {
                peripheral.stopAdvertising()
            }

            let uuid = CBUUID(string: Constants.SERVICE_UUID.rawValue)
            var advertisingData: [String : Any] = [
                CBAdvertisementDataServiceUUIDsKey: [uuid]
            ]

            if let name = self.name {
                advertisingData[CBAdvertisementDataLocalNameKey] = name
            }
            self.peripheralManager?.startAdvertising(advertisingData)
        } else {
            #warning("handle other states")
        }
    }
}

extension BLEConnection: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {

            if central.isScanning {
                central.stopScan()
            }

            let uuid = CBUUID(string: Constants.SERVICE_UUID.rawValue)
            central.scanForPeripherals(withServices: [uuid])
        } else {
            #warning("Error handling")
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        peripherals[peripheral.identifier] = peripheral
    }
}
