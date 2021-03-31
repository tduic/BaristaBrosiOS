//
//  ContentView.swift
//  BaristaBrosiOS
//
//  Created by Tyler Duic on 3/22/21.
//

import SwiftUI

struct SignupView: View {
    
    @Binding var page: Pages
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    var body: some View {
        VStack {
            Text("Sign Up")
            VStack {
                TextField("First", text: $firstName)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                TextField("Last", text: $lastName)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                TextField("Email", text: $email)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                SecureField("Password", text: $password)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                SecureField("Retype Password", text: $confirmPassword)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                Button(action: {page = Pages.Home}) {
                    SignupButtonContent()
                }
            }
            .padding()
        }
    }
}

struct SignupButtonContent: View {
    var body: some View {
        Text("Sign Up")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}
