//
//  Drink.swift
//  BaristaBrosiOS
//
//  Created by Aryan Chordia on 4/5/21.
//

import Foundation
import SwiftUI

struct Drink: Hashable, Codable {
    var name: String
    var alcohols: [String: Int16]
    var mixers: [String: Int16]
    var calories: Int16
    var rating: Double
    var ice: Bool
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}

extension Drink {
    static var AllDrinks: [Drink] {
        [
            Drink(name: "Tequila Sunrise", alcohols: ["Tequila": 40], mixers: ["Orange Juice": 80], calories: 232, rating: 5, ice: true, imageName: "TS"),
            Drink(name: "Tequila Coke", alcohols: ["Tequila" : 40], mixers: ["Coca Cola": 80], calories: 200, rating: 5, ice: true, imageName: "TC"),
            Drink(name: "Screwdriver", alcohols: ["Vodka" : 40], mixers: ["Orange Juice": 80], calories: 200, rating: 5, ice: true, imageName: "SD"),
            Drink(name: "Vodka Coke", alcohols: ["Vodka" : 40], mixers: ["Coca Cola": 80], calories: 200, rating: 5, ice: true, imageName: "VC"),
            Drink(name: "Vodka Tonic", alcohols: ["Vodka" : 80], mixers: ["Tonic" : 160], calories: 183, rating: 4, ice: true, imageName: "VT"),
            Drink(name: "Gin & Tonic", alcohols: ["Gin" : 80], mixers: ["Tonic" : 160], calories: 125, rating: 4, ice: true, imageName: "GT"),
            Drink(name: "Screwdriver", alcohols: ["Vodka" : 90], mixers: ["Orange Juice" : 130], calories: 164, rating: 4.5, ice: true, imageName: ""),
            Drink(name: "Moscow Mule", alcohols: ["Vodka" : 50, "Ginger Beer": 120], mixers: ["Lime Juice" : 20], calories: 182, rating: 3.5, ice: true, imageName: ""),
            Drink(name: "Long Island Ice Tea", alcohols: ["Vodka" : 20, "Rum": 20, "Tequila": 20, "Gin": 20], mixers: ["Triple Sec" : 20, "Cola": 40, "Lime Juice": 40], calories: 780, rating: 4, ice: true, imageName: ""),
            Drink(name: "Whiskey Sour", alcohols: ["Whiskey" : 60], mixers: ["Lime Juice" : 10, "Orange Juice": 10, "Syrup": 10], calories: 48, rating: 4.5, ice: true, imageName: ""),
            Drink(name: "Old Fashinoned", alcohols: ["Whiskey" : 60], mixers: ["Bitters" : 10, "Syrup": 10], calories: 151, rating: 3.5, ice: true, imageName: "OF"),
            Drink(name: "Mojito", alcohols: ["Rum" : 40], mixers: ["Lime Juice" : 30, "Syrup": 10], calories: 255, rating: 4, ice: true, imageName: ""),
            Drink(name: "Manhattan", alcohols: ["Whiskey" : 60], mixers: ["Vermouth" : 20], calories: 151, rating: 5, ice: true, imageName: "")
        ]
    }
}
