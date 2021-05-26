//
//  WeatherListViewModel.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/05/26.
//

import Foundation

class WeatherListViewModel {
    
}

class WeatherViewModel {
    let weather:WeatherResponse
    
    init(weather:WeatherResponse) {
        self.weather = weather
    }
    
    var city:String {
        return weather.name
    }
    
    var temperature:Double {
        return weather.main.temp
    }
}
