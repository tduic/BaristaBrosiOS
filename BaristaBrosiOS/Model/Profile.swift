//
//  Profile.swift
//  BaristaBrosiOS
//
//  Created by Aryan Chordia on 3/30/21.
//

import Foundation

struct UserProfile: Codable {
    var firstName: String
    var lastName: String
    var nickName: String
    var age: Int16
    var password: String
    var email: String
    
    
}

extension UserProfile {
    static var users: [UserProfile] {
        [
        UserProfile(firstName: "aryan", lastName: "chordia", nickName: "ac", age: 21, password: "123", email: "aryanchordia@gmail.com")
        ]
    }
}

extension UserProfile {
    struct Data {
        var firstName: String = ""
        var lastName: String = ""
        var nickName: String = ""
        var age: Int16 = 21
        var password: String = ""
        var email: String = ""
    }
    
    var data: Data {
        return Data(firstName: firstName, lastName: lastName, nickName: nickName, age: age, password: password, email: email)
    }
}
