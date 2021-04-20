//
//  DispenseView.swift
//  BaristaBrosiOS
//
//  Created by Tyler Duic on 4/19/21.
//

import SwiftUI
import CoreBluetooth

struct DispenseView: View {
    
    @Binding var page: Pages
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("Dispense")
            }
            .navigationTitle("Barista Bros")
        }
    }
}

struct DispenseView_Previews: PreviewProvider {
    static var previews: some View {
        DispenseView(page: .constant(Pages.Dispense))
    }
}
