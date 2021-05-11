//
//  CheckLiquidView.swift
//  BaristaBrosiOS
//
//  Created by Tyler Duic on 5/2/21.
//

import SwiftUI

struct CheckLiquidView: View {
    
    @Binding var page: Pages
    
    private let ble = BLEConnection()
    
//    @State var readValues = ["", "", "", ""]
    @State var readValue = ""
    @State var readValue1 = ""
    @State var readValue2 = ""
    @State var readValue3 = ""
    @State var timeRemaining = 3
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var liquid = Liquid.AllLiquids
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        liquid[0].image
                            .resizable()
                            .frame(width:80, height: 80)
                        Text(liquid[0].name)
                        Text("\(readValue)")
                            .onReceive(timer) {
                                input in
                                readValue = timeRemaining > 0
                                    ? "Checking values..."
                                    : ble.readValue == ""
                                        ? ble.readValue
                                        : String(Int(ble.readValue[ble.readValue.startIndex].asciiValue!) * 10)
                            }
                        Button(action: {refillLiquid(liquid: "V", name: "Vodka")}) {
                            RefillButtonContent()
                        }
                        
                        Spacer()
                            .frame(height: 25)
                
                        liquid[1].image
                            .resizable()
                            .frame(width:80, height: 80)
                        Text(liquid[1].name)
                        Text("\(readValue1)")
                            .onReceive(timer) {
                                input in
                                readValue1 = timeRemaining > 0
                                    ? "Checking values..."
                                    : ble.readValue == ""
                                        ? ble.readValue
                                        : String(Int(ble.readValue[ble.readValue.index(ble.readValue.startIndex, offsetBy: 1)].asciiValue!) * 10)
                            }
                        Button(action: {refillLiquid(liquid: "T", name: "Tequila")}) {
                            RefillButtonContent()
                        }
                    }
                    
                    Spacer()
                        .frame(width: 30)
                    
                    VStack {
                        liquid[2].image
                            .resizable()
                            .frame(width:80, height: 80)
                        Text(liquid[2].name)
                        Text("\(readValue2)")
                            .onReceive(timer) {
                                input in
                                readValue2 = timeRemaining > 0
                                    ? "Checking values..."
                                    : ble.readValue == ""
                                        ? "ble.readValue"
                                        : String(Int(ble.readValue[ble.readValue.index(ble.readValue.startIndex, offsetBy: 2)].asciiValue!) * 10)
                            }
                        Button(action: {refillLiquid(liquid: "C", name: "Coca Cola")}) {
                            RefillButtonContent()
                        }
                        
                        Spacer()
                            .frame(height: 25)
                
                        liquid[3].image
                            .resizable()
                            .frame(width:80, height: 80)
                        Text(liquid[3].name)
                        Text("\(readValue3)")
                            .onReceive(timer) {
                                input in
                                readValue3 = timeRemaining > 0
                                    ? "Checking values..."
                                    : ble.readValue == ""
                                        ? ble.readValue
                                        : String(Int(ble.readValue[ble.readValue.index(before: ble.readValue.endIndex)].asciiValue!) * 10)
                            }
                        Button(action: {refillLiquid(liquid: "O", name: "Orange Juice")}) {
                            RefillButtonContent()
                        }
                    }
                }
                Spacer()
                    .frame(height: 25)
                Button(action: {page = Pages.Home}) {
                    ReturnHomeButtonContent()
                }
            }
            .navigationTitle("Liquid Status")
        }
        .onAppear(perform: initBLE)
        .onReceive(timer) {
            _ in if timeRemaining > 0 {
                timeRemaining -= 1
            }
            if (timeRemaining == 0) {
                checkLiquid()
            }
        }
    }
    
    func initBLE() {
        print("connect BLE device")
        ble.initBLE()
    }
    
    func checkLiquid() {
        let check = "L"
        ble.bleWriteCharacteristic(uuid: ble.uuidHM10Char, data: check.data(using: .utf8) ?? Data())
    }
    
    func refillLiquid(liquid: String, name: String) {
        ble.bleWriteCharacteristic(uuid: ble.uuidHM10Char, data: liquid.data(using: .utf8) ?? Data())
    }
}

struct CheckLiquidView_Previews: PreviewProvider {
    static var previews: some View {
        CheckLiquidView(page: .constant(Pages.CheckLiquid))
    }
}

struct RefillButtonContent: View {
    var body: some View {
        Text("Refill")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 80, height: 30)
            .background(Color.blue)
            .cornerRadius(15.0)
    }
}
