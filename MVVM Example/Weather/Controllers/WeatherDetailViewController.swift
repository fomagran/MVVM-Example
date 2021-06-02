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
        
        if let weatherVM = self.weatherViewModel {
            self.cityName.text = weatherVM.city
            self.currentTemp.text = "\(weatherVM.temperature)"
        }
        
    }
}
