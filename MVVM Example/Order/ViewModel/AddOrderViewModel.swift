//
//  AddOrderViewModel.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/04/05.
//

import Foundation

struct AddOrderViewModel {
    var name:String?
    var email:String?
    
    var types:[String] {
        return CoffeeType.allCases.map{$0.rawValue.capitalized}
    }
    
    var sizes:[String] {
        return CoffeeSize.allCases.map{$0.rawValue.capitalized}
    }
}
