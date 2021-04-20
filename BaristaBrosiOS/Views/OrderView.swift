//
//  OrderView.swift
//  BaristaBrosiOS
//
//  Created by Tyler Duic on 4/19/21.
//

import SwiftUI

struct OrderView: View {
    
    @Binding var page: Pages
    
    private let ble = BLEConnection()
    
    var drink = Drink.AllDrinks
    
    var body: some View {
        
        NavigationView {
            HStack {
                VStack {
                    drink[0].image
                        .resizable()
                        .frame(width:80, height: 80)
                    Text(drink[0].name)
                    Button(action: {page = orderDrink(drink: 0, name: drink[0].name)}) {
                        OrderButtonContent()
                    }
                    Spacer()
                        .frame(height: 25)
            
                    drink[1].image
                        .resizable()
                        .frame(width: 80, height: 80)
                    Text(drink[1].name)
                    Button(action: {page = orderDrink(drink: 1, name: drink[1].name)}) {
                        OrderButtonContent()
                    }
                }
                
                Spacer()
                    .frame(width: 30)
            
                VStack {
                    drink[2].image
                        .resizable()
                        .frame(width: 80, height: 80)
                    Text(drink[2].name)
                    Button(action: {page = orderDrink(drink: 2, name: drink[2].name)}) {
                        OrderButtonContent()
                    }
                    Spacer()
                        .frame(height: 25)
            
                    drink[7].image
                        .resizable()
                        .frame(width: 80, height: 80)
                    Text(drink[7].name)
                    Button(action: {page = orderDrink(drink: 7, name: drink[7].name)}) {
                        OrderButtonContent()
                    }
                }
            }
            .navigationTitle("Order a Drink")
        }
        .onAppear(perform: connectBLEDevice)
    }
    
    private func connectBLEDevice() {
        print("connect BLE device")
        ble.initBLE()
    }
    
    func orderDrink(drink: Int, name: String) -> Pages {
        let format = String(format: "%d: %s\n", drink, name)
        ble.bleWriteCharacteristic(uuid: ble.uuidHM10Char, data: format.data(using: .utf8) ?? Data())
        return Pages.Dispense
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(page: .constant(Pages.Order))
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
