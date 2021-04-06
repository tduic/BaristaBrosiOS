//
//  Drink.swift
//  BaristaBrosiOS
//
//  Created by Aryan Chordia on 4/5/21.
//

import Foundation

struct Drink: Codable {
    var name: String
    var alcohols: [String: Int16]
    var mixers: [String: Int16]
    var calories: Int16
    var rating: Double
    var ice: Bool
}

extension Drink {
    static var AllDrinks: [Drink] {
        [
            Drink(name: "Vodka Tonic", alcohols: ["Vodka" : 80], mixers: ["Tonic" : 145], calories: 183, rating: 4, ice: true),
            Drink(name: "Gin & Tonic", alcohols: ["Gin" : 80], mixers: ["Tonic" : 145], calories: 125, rating: 4, ice: true),
            Drink(name: "Tequila Sunrise", alcohols: ["Corona" : 130, "Tequila": 40], mixers: ["Blue Curacao" : 10, "Orange Juice": 40], calories: 232, rating: 5, ice: true),
            Drink(name: "Screwdriver", alcohols: ["Vodka" : 95], mixers: ["Orange Juice" : 135], calories: 164, rating: 4.5, ice: true),
            Drink(name: "Moscow Mule", alcohols: ["Vodka" : 45, "Ginger Beer": 125], mixers: ["Lime Juice" : 20], calories: 182, rating: 3.5, ice: true),
            Drink(name: "Long Island Ice Tea", alcohols: ["Vodka" : 20, "Rum": 20, "Tequila": 20, "Gin": 20], mixers: ["Triple Sec" : 20, "Cola": 40, "Lime Juice": 40], calories: 780, rating: 4, ice: true),
            Drink(name: "Whiskey Sour", alcohols: ["Whiskey" : 60], mixers: ["Lime Juice" : 8, "Orange Juice": 8, "Syrup": 8], calories: 48, rating: 4.5, ice: true),
            Drink(name: "Old Fashinoned", alcohols: ["Whiskey" : 60], mixers: ["Bitters" : 8, "Syrup": 8], calories: 151, rating: 3.5, ice: true),
            Drink(name: "Mojito", alcohols: ["Rum" : 45], mixers: ["Lime Juice" : 30, "Syrup": 8], calories: 255, rating: 4, ice: true),
            Drink(name: "Manhattan", alcohols: ["Whiskey" : 60], mixers: ["Vermouth" : 22], calories: 151, rating: 5, ice: true)
        ]
    }
}
