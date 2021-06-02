//
//  AddWeatherViewModel.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/05/26.
//

import Foundation

class AddWeatherViewModel {
    func addWeather(city:String,completion:@escaping(WeatherViewModel) -> Void) {
        let weatherURL = Constants.URLs.urlForWeatherByCity(city: city)
        let weatherResource = WeatherResource<WeatherViewModel>(url: weatherURL) { data in
            return try? JSONDecoder().decode(WeatherViewModel.self, from:data)
        }
        
        WeatherWebService().load(resource: weatherResource) { result in
            if let weatherResource = result {
                completion(weatherResource)
            }
        }
    }
}
