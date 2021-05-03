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
    
    private let ble = BLEConnection()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("some shit")
            }
            .navigationTitle("Liquid Status")
        }
        .onAppear(perform: connectBLEDevice)
    }
    
    private func connectBLEDevice() {
        print("connect BLE device")
        ble.initBLE()
    }
}

struct CheckLiquidView_Previews: PreviewProvider {
    static var previews: some View {
        CheckLiquidView(page: .constant(Pages.CheckLiquid), readValue: .constant(""))
    }
}

