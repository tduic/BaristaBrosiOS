//
//  OrderView.swift
//  BaristaBrosiOS
//
//  Created by Tyler Duic on 4/19/21.
//

import SwiftUI

struct OrderView: View {
    
    @Binding var page: Pages
    @State var drinkNum = -1
    
    private let ble = BLEConnection()
    
    @State var readValue = ""
    @State var timeRemaining = 2
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var drink = Drink.AllDrinks
    
    var body: some View {
        
        if (drinkNum != -1) {
            NavigationView{
                VStack{
                    drink[drinkNum].image
                        .resizable()
                        .frame(width: 160, height: 160)
                    Text(drink[drinkNum].name)
                        .bold()
                    Spacer()
                        .frame(height: 25)
                    Text("\(readValue)")
                        .onReceive(timer) {
                            input in readValue = ble.readValue
                        }
                    if (ble.readValue == "Dispensed!") {
                        Button(action: {page = Pages.Home}) {
                            ReturnHomeButtonContent()
                        }
                    }
                }
                .navigationTitle("Order Placed")
            }
        } else {
            NavigationView {
                VStack {
                    HStack {
                        VStack {
                            drink[0].image
                                .resizable()
                                .frame(width:80, height: 80)
                            Text(drink[0].name)
                            Button(action: {page = orderDrink(drink: 0, name: drink[0].name)}) {
                                OrderButtonContent()
                            }.opacity(timeRemaining > 0 ? 0 : 1)
                            Spacer()
                                .frame(height: 25)
                    
                            drink[1].image
                                .resizable()
                                .frame(width: 80, height: 80)
                            Text(drink[1].name)
                            Button(action: {page = orderDrink(drink: 1, name: drink[1].name)}) {
                                OrderButtonContent()
                            }.opacity(timeRemaining > 0 ? 0 : 1)
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
                            }.opacity(timeRemaining > 0 ? 0 : 1)
                            Spacer()
                                .frame(height: 25)
                    
                            drink[3].image
                                .resizable()
                                .frame(width: 80, height: 80)
                            Text(drink[3].name)
                            Button(action: {page = orderDrink(drink: 3, name: drink[3].name)}) {
                                OrderButtonContent()
                            }.opacity(timeRemaining > 0 ? 0 : 1)
                        }
                    }
                    Spacer()
                        .frame(height: 25)
                    Button(action: {page = Pages.Home}) {
                        ReturnHomeButtonContent()
                    }
                }
                .navigationTitle("Order a Drink")
            }
            .onAppear(perform: connectBLEDevice)
            .onReceive(timer) {
                _ in if timeRemaining > 0 {
                    timeRemaining -= 1
                }
            }
        }
    }
    
    private func connectBLEDevice() {
        print("connect BLE device")
        ble.initBLE()
    }
    
    func orderDrink(drink: Int, name: String) -> Pages {
        drinkNum = drink
        let format = String(format: "%d: %s\n", drink, name)
        ble.bleWriteCharacteristic(uuid: ble.uuidHM10Char, data: format.data(using: .utf8) ?? Data())
        print(ble.readValue)
        return Pages.Order
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

struct ReturnHomeButtonContent: View {
    var body: some View {
        Text("Return Home")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 300, height: 80)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}
