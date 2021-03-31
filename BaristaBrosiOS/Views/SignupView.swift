//
//  ContentView.swift
//  BaristaBrosiOS
//
//  Created by Tyler Duic on 3/22/21.
//

import SwiftUI
import CoreData

//let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct SignupView: View {
    
    @State private var userData: UserProfile.Data = UserProfile.Data()
    @State var confirmPassword: String = ""

    var body: some View {
        
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
            Button(action: {print("button pressed")}) {
                SignupButtonContent()
            }
            
        }
        .padding()
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
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
