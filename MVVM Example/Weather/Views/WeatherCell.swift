//
//  WeatherCell.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/05/26.
//

import UIKit

class WeatherCell:UITableViewCell {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    
    func configure(vm:WeatherViewModel) {
        self.cityName.text = vm.name.value
        self.temperature.text = String(vm.currentTemperature.temperature.value) + "°C"
    }
    
}
