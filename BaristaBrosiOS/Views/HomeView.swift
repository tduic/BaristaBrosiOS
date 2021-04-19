//
//  HomeView.swift
//  BaristaBrosiOS
//
//  Created by Tyler Duic on 3/29/21.
//

import SwiftUI
import CoreBluetooth

struct HomeView: View {
    
    @Binding var page: Pages
    
    private let ble = BLEConnection()
    var drink = Drink.AllDrinks
    
    var body: some View {
        
        VStack {
            
            Group {
                drink[0].image
                    .resizable()
                    .frame(width:80, height: 80)
                Text(drink[0].name)
                Button(action: {ble.bleWriteCharacteristic(uuid: ble.uuidHM10Char, data: "0: vodka tonic\n".data(using: .utf8) ?? Data())}) {
                    OrderButtonContent()
                }
                Spacer()
                    .frame(height: 25)
                
                drink[1].image
                    .resizable()
                    .frame(width: 80, height: 80)
                Text(drink[1].name)
                Button(action: {ble.bleWriteCharacteristic(uuid: ble.uuidHM10Char, data: "1: gin & tonic\n".data(using: .utf8) ?? Data())}) {
                    OrderButtonContent()
                }
                Spacer()
                    .frame(height: 25)
            }
            
            Group {
                drink[2].image
                    .resizable()
                    .frame(width: 80, height: 80)
                Text(drink[2].name)
                Button(action: {ble.bleWriteCharacteristic(uuid: ble.uuidHM10Char, data: "2: tequila sunrise\n".data(using: .utf8) ?? Data())}) {
                    OrderButtonContent()
                }
                Spacer()
                    .frame(height: 25)
                
                drink[7].image
                    .resizable()
                    .frame(width: 80, height: 80)
                Text(drink[7].name)
                Button(action: {ble.bleWriteCharacteristic(uuid: ble.uuidHM10Char, data: "7: old fashioned\n".data(using: .utf8) ?? Data())}) {
                    OrderButtonContent()
                }
            }
            
            
        }
        .onAppear(perform: connectBLEDevice)
    }
    
    private func connectBLEDevice() {
        print("connect BLE device")
        ble.initBLE()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(page: .constant(Pages.Home))
    }
}

struct OrderButtonContent: View {
    var body: some View {
        Text("Order")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 80, height: 30)
            .background(Color.blue)
            .cornerRadius(15.0)
    }
}
