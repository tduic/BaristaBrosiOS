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
    
    var body: some View {
        
        NavigationView {
            VStack {
                Button(action: {page = Pages.Order}) {
                    NewOrderButtonContent()
                }
                NavigationLink(
                    destination: OrderView(page: $page, readValue: .constant("")),
                    label: {
                        CheckLiquidsButtonContent()
                    }
                )
            }
            .navigationTitle("Barista Bros")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(page: .constant(Pages.Home))
    }
}

struct NewOrderButtonContent: View {
    var body: some View {
        Text("New Order")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 300, height: 80)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

struct CheckLiquidsButtonContent: View {
    var body: some View {
        Text("Check Liquids")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 300, height: 80)
            .background(Color.orange)
            .cornerRadius(15.0)
    }
}
