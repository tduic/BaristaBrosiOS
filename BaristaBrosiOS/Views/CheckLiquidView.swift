//
//  CheckLiquidView.swift
//  BaristaBrosiOS
//
//  Created by Tyler Duic on 5/2/21.
//

import SwiftUI

struct CheckLiquidView: View {
    
    @Binding var page: Pages
    @Binding var readValue: String
    @State var liquidNum = "-1"
    
    private let ble = BLEConnection()
    
    var liquid = Liquid.AllLiquids
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        liquid[0].image
                            .resizable()
                            .frame(width:80, height: 80)
                        Text(verbatim: liquid[0].name)
                        Text(readValue.dropFirst().components(separatedBy: ",")[0])
                        Button(action: {refillLiquid(liquid: "R", name: "Vodka")}) {
                            RefillButtonContent()
                        }
                        Spacer()
                            .frame(height: 25)
                
                        liquid[1].image
                            .resizable()
                            .frame(width:80, height: 80)
                        Text(verbatim: liquid[1].name)
                        Text(readValue.dropLast().components(separatedBy: ",")[1])
                        Button(action: {refillLiquid(liquid: "r", name: "Red Bull")}) {
                            RefillButtonContent()
                        }
                    }
                }
            }
            .navigationTitle("Liquid Status")
        }
        .onAppear(perform: checkLiquid)
    }
    
    private func checkLiquid() {
        print("connect BLE device")
        ble.initBLE()
        let check = "C: check liquids"
        ble.bleWriteCharacteristic(uuid: ble.uuidHM10Char, data: check.data(using: .utf8) ?? Data())
    }
    
    func refillLiquid(liquid: String, name: String) {
        liquidNum = liquid
        let format = String(format: "%s: %s\n", liquidNum, name)
        ble.bleWriteCharacteristic(uuid: ble.uuidHM10Char, data: format.data(using: .utf8) ?? Data())
    }
}

struct CheckLiquidView_Previews: PreviewProvider {
    static var previews: some View {
        CheckLiquidView(page: .constant(Pages.CheckLiquid), readValue: .constant("{750, 750}"))
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
