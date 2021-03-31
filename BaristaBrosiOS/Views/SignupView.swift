//
//  ContentView.swift
//  BaristaBrosiOS
//
//  Created by Tyler Duic on 3/22/21.
//

import SwiftUI

struct SignupView: View {
    
    @Binding var page: Pages
    
    @State private var userData: UserProfile.Data = UserProfile.Data()
    @State var confirmPassword: String = ""

    var body: some View {
        
        VStack {
            Text("Sign Up")
            VStack {
                TextField("First", text: $userData.firstName)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                TextField("Last", text: $userData.lastName)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                TextField("Email", text: $userData.email)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                SecureField("Password", text: $userData.password)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                SecureField("Confirm Password", text: $confirmPassword)
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
