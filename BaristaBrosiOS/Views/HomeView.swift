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
    
    var body: some View {
        
        VStack{
            Text("Hello, World!")
            Text("what up")
            Button(action: {page = Pages.Login}) {
                LoginButtonContent()
            }
        }
        .onAppear(perform: connectBLEDevice)
    }
    
    private func connectBLEDevice() {
        print("connect BLE device")
        ble.startCentralManager()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(page: .constant(Pages.Home))
    }
}
