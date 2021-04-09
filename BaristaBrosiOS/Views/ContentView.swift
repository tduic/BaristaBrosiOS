//
//  ContentView.swift
//  BaristaBrosiOS
//
//  Created by Tyler Duic on 3/22/21.
//

import SwiftUI
import CoreData

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct ContentView: View {
    
    @State private var page = Pages.Login
    
    var body: some View {
        switch page {
        case .Login:
            NavigationView {
                VStack {
                    LoginView(page: $page)
                        .navigationTitle("Barista Bros")
                    NavigationLink(
                        destination: SignupView(page: $page),
                        label: {
                            SignupButtonContent()
                        }
                    )
                }
            }
        case .Home:
            VStack {
                HomeView(page: $page)
            }
        
        default:
            HomeView(page: $page)
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
}
