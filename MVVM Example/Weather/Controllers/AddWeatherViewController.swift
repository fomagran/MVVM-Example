//
//  AddWeatherViewController.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/05/04.
//

import UIKit

class AddWeatherViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cityTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tapSaveButton(_ sender: Any) {
        
        if let city = cityTF.text {
            let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(WeatherKey().key)&units=imperial")!
            
            let weatherResource = WeatherResource<Any>(url:weatherURL){
                data in return data
            }
            WeatherWebService().load(resource: weatherResource) { result in
                
            }
        
        }
    }
    
    @IBAction func tapCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
