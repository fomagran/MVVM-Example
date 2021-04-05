//
//  Order.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/03/29.
//

import Foundation

enum CoffeeType:String,Codable,CaseIterable {
    case cappuccino
    case latte
    case espresso
    case cortado
}

enum CoffeeSize:String,Codable,CaseIterable {
    case small
    case medium
    case large
}

struct Order :Codable{
    var name:String?
    var email:String?
    var type:CoffeeType?
    var size:CoffeeSize?
}
