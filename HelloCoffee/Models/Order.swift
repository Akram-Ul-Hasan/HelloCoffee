//
//  Order.swift
//  HelloCoffee
//
//  Created by Akram Ul Hasan on 12/1/25.
//

import Foundation
enum CoffeeSize : String, Codable, CaseIterable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
}

struct Order : Codable, Identifiable, Hashable {
    
    var id : Int?
    var name : String
    var CoffeeName : String
    var count : Int
    var size : CoffeeSize
    
}
