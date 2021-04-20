//
//  ContentView.swift
//  BaristaBrosiOS
//
//  Created by Tyler Duic on 3/22/21.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct ContentView: View {
    
    @State private var page = Pages.Login
    
    var body: some View {
        switch page {
        case .Login:
            LoginView(page: $page)
                .navigationTitle("Barista Bros")
        case .Home:
            HomeView(page: $page)
        case .Dispense:
            DispenseView(page: $page)
        default:
            NavigationView {
                VStack {
                    Text("Go back dumbass, page not implemented.")
                }
                .navigationTitle("You Blew It")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum Pages : Int {
    case Login = 0
    case Signup = 1
    case Home = 2
    case Dispense = 3
    case Order = 4
}
