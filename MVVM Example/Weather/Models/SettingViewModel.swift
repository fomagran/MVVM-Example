//
//  SettingViewModel.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/05/26.
//

import Foundation

enum Unit:String,CaseIterable {
    case celsius = "metric"
    case fahrenheit = "imperial"
}

extension Unit {
    var displayName:String {
        get {
            switch self {
            case .celsius:
                return "Celcius"
            default:
                return "Fahrenheit"
            }
        }
    }
}

class SettingViewModel {
    let units = Unit.allCases
    
    var selectedUnit:Unit {

        get {
            let userDefault = UserDefaults.standard
            var unitValue = ""
            if let value =  userDefault.value(forKey: "unit") as? String {
                unitValue = value
            }
            
            return Unit(rawValue: unitValue) ?? .fahrenheit
        }
        set {
            let userDefault = UserDefaults.standard
            userDefault.setValue(newValue.rawValue, forKey: "unit")
        }
    }
}


