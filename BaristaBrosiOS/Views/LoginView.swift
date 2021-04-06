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
            Button(action: {page = authenticate(email: email, password: password)}) {
                LoginButtonContent()
            }
            Text("Don't have an account?")
        }
        .padding(.horizontal)
    }
    
    func authenticate(email: String, password: String) -> Pages {
        let allUsers = UserProfile.users
        print(allUsers)
        for user in allUsers {
            if user.email == email.lowercased(){
                print("EMAIL MATCHES")
                if user.password == password {
                    print("PASSWORD MATCHES")
                    return Pages.Home
                }
            }
            
        }
        return Pages.Login
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView(page: .constant(Pages.Login)).navigationTitle("Barista Bros")
        }
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
