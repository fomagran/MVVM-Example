//
//  WeatherListViewModel.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/05/26.
//

import Foundation

class WeatherListViewModel {
    
    private var weatherViewModels = [WeatherViewModel]()
    
    func addWeatherViewModel(vm:WeatherViewModel) {
        weatherViewModels.append(vm)
    }
    
    func numberOfRows(section:Int) -> Int {
        return weatherViewModels.count
    }
    
    func modelAt(index:Int) -> WeatherViewModel {
        return weatherViewModels[index]
    }
    
    private func toCelcius() {
        weatherViewModels =  weatherViewModels.map { vm in
            let weatherModel = vm
            weatherModel.temperature = floor(Double((weatherModel.temperature - 32) * 5/9))
            return weatherModel
        }
    }
    
    private func toFahrenheit() {
        weatherViewModels =  weatherViewModels.map { vm in
            let weatherModel = vm
            weatherModel.temperature = (weatherModel.temperature * 9/5) + 32
            return weatherModel
        }
    }
    
    func updateUnit(to unit:Unit) {
        switch unit {
        case .celsius:
            toCelcius()
        default:
            toFahrenheit()
        }
    }
    
    
}

class WeatherViewModel {
    let weather:WeatherResponse
    var temperature:Double
    
    init(weather:WeatherResponse) {
        self.weather = weather
        temperature = weather.main.temp
    }
    
    var city:String {
        return weather.name
    }
    

}
