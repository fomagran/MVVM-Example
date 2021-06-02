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
            weatherModel.currentTemperature.temperature.value = floor((weatherModel.currentTemperature.temperature.value - 32) * 5/9)
            return weatherModel
        }
    }
    
    private func toFahrenheit() {
        weatherViewModels =  weatherViewModels.map { vm in
            let weatherModel = vm
            weatherModel.currentTemperature.temperature.value = floor((weatherModel.currentTemperature.temperature.value * 9/5) + 32)
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

class Dynamic<T>: Decodable where T:Decodable {
    
    typealias Listener = (T) -> ()
    var listener:Listener?
    
    var value:T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener:@escaping Listener) {
        self.listener = listener
        self.listener?(self.value)
    }
    
    init(_ value:T) {
        self.value = value
    }
    
    private enum CodingKeys:CodingKey {
        case value
    }
}

struct WeatherViewModel: Decodable {
    
    let name: Dynamic<String>
    var currentTemperature: TemperatureViewModel
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = Dynamic(try container.decode(String.self, forKey: .name))
        currentTemperature = try container.decode(TemperatureViewModel.self, forKey: .currentTemperature)
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case currentTemperature = "main"
    }
    
}

struct TemperatureViewModel: Decodable {
    
    var temperature: Dynamic<Double>
    let temperatureMin: Dynamic<Double>
    let temperatureMax: Dynamic<Double>
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperature = Dynamic(try container.decode(Double.self, forKey: .temperature))
        temperatureMin = Dynamic(try container.decode(Double.self, forKey: .temperatureMin))
        temperatureMax = Dynamic(try container.decode(Double.self, forKey: .temperatureMax))
        
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}

