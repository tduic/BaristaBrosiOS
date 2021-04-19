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
                Button(action: {page = signup()}) {
                    SignupButtonContent()
                }
            }
            .padding()
        }
        
    }
    func signup() -> Pages {
        _ = UserProfile(firstName: userData.firstName.lowercased(), lastName: userData.lastName.lowercased(), age: 21, password: userData.password, email: userData.email.lowercased())
        return Pages.Home
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(page: .constant(Pages.Signup))
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
