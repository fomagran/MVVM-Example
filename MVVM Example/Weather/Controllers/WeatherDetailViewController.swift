//
//  WeatherDetailViewController.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/06/02.
//

import UIKit

class WeatherDetailViewController:UIViewController {
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    
    var weatherViewModel:WeatherViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        if let weatherVM = self.weatherViewModel {
            weatherVM.name.bind { self.cityName.text = $0 }
            weatherVM.currentTemperature.temperature.bind {self.currentTemp.text = String($0)}
        }
    }
}
