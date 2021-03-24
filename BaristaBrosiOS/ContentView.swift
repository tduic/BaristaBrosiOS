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
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        
        VStack {
            WelcomeText()
            TextField("Email", text: $email)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
            SecureField("Password", text: $password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
            Button(action: {print("login button pressed")}) {
                LoginButtonContent()
            }
            Text("or")
            Button(action: {print("signup button pressed")}) {
                SignupButtonContent()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WelcomeText: View {
    var body: some View {
        Text("Welcome to Barista Bros")
            .font(.title)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .padding()
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
