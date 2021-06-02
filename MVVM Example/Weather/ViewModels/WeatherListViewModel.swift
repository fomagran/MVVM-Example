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
            weatherModel.currentTemp.temp.value = floor((weatherModel.currentTemp.temp.value - 32) * 5/9)
            return weatherModel
        }
    }
    
    private func toFahrenheit() {
        weatherViewModels =  weatherViewModels.map { vm in
            let weatherModel = vm
            weatherModel.currentTemp.temp.value = floor((weatherModel.currentTemp.temp.value * 9/5) + 32)
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

struct WeatherViewModel:Decodable {
    
    let city:Dynamic<String>
    var currentTemp:TemperatureViewModel
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        city = Dynamic(try container.decode(String.self, forKey: .city))
        currentTemp = try container.decode(TemperatureViewModel.self, forKey: .currentTemmp)
    }
    
    private enum Codingkeys:String,CodingKey {
        case city
        case currentTemmp = "main"
    }
    
}

struct TemperatureViewModel:Decodable {
    var temp:Dynamic<Double>
    var tempMin:Dynamic<Double>
    var tempMax:Dynamic<Double>
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        temp = Dynamic(try container.decode(Double.self, forKey: .temp))
        tempMin = Dynamic(try container.decode(Double.self, forKey: .tempMin))
        tempMax = Dynamic(try container.decode(Double.self, forKey: .tempMax))
    }
    
    private enum Codingkeys:String,CodingKey {
        case temp = "temp"
        case tempMin = "tempMin"
        case tempMax = "tempMax"
    }
}


