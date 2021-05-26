//
//  Constants.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/05/26.
//

import Foundation

struct Constants {
    struct URLs {
        static func urlForWeatherByCity(city:String) -> URL {
            return URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(WeatherKey().key)&units=imperial")!
        }
    }
}
