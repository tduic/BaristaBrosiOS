//
//  Liquid.swift
//  BaristaBrosiOS
//
//  Created by Tyler Duic on 5/10/21.
//

import Foundation
import SwiftUI

struct Liquid: Hashable, Codable {
    var name: String
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}

extension Liquid {
    static var AllLiquids: [Liquid] {
        [
            Liquid(name: "Vodka", imageName: "GG"),
            Liquid(name: "Red Bull", imageName: "RB")
        ]
    }
}

