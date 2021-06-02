//
//  AddWeatherViewController.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/05/04.
//

import UIKit

protocol AddWeatherDelegate {
    func addWeatherDidSave(vm:WeatherViewModel)
}

class AddWeatherViewController: UIViewController {
    
    private var addCityViewModel = AddCityViewModel()

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cityTF: BindingTextField! {
        didSet {
            cityTF.bind { self.addCityViewModel.city = $0 }
        }
    }
    @IBOutlet weak var stateTF: BindingTextField! {
        didSet {
            stateTF.bind { self.addCityViewModel.city = $0 }
        }
    }
    @IBOutlet weak var zipCodeTF: BindingTextField! {
        didSet {
            zipCodeTF.bind { self.addCityViewModel.city = $0 }
        }
    }
    
    var delegate:AddWeatherDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tapSaveButton(_ sender: Any) {
        
        if let city = cityTF.text {
            let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=1a5b183fc3a82b25cc1095a55e549a0b&units=imperial")!
            
            let weatherResource = WeatherResource<WeatherViewModel>(url: weatherURL) { data in
                
                let weatherVM = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
                return weatherVM
            }
            
            WeatherWebService().load(resource: weatherResource) { [weak self] result in
                if let weatherVM = result {
                    if let delegate = self?.delegate {
                        delegate.addWeatherDidSave(vm: weatherVM)
                        self?.dismiss(animated: true, completion: nil)
                    }
                    
                }
                
            }
        }
    }
    
    @IBAction func tapCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
