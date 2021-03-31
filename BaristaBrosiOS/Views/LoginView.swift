//
//  LoginView.swift
//  BaristaBrosiOS
//
//  Created by Tyler Duic on 3/24/21.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var page: Pages
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        
        VStack {
            TextField("Email", text: $email)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
            SecureField("Password", text: $password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
            Button(action: {page = Pages.Home}) {
                LoginButtonContent()
            }
            Text("Don't have an account?")
        }
        .padding(.horizontal)
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("Login")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}
