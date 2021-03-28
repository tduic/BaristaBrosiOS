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
    var body: some View {
        NavigationView {
            VStack {
                LoginView()
                    .navigationTitle("Barista Bros")
                NavigationLink(
                    destination: SignupView(),
                    label: {
                        SignupButtonContent()
                    }
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
