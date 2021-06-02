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
    
    private var addWeatherVM = AddWeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tapSaveButton(_ sender: Any) {
        
        print(self.addCityViewModel)
        
        if let city = cityTF.text {
            addWeatherVM.addWeather(city: city) { viewModel in
                self.delegate?.addWeatherDidSave(vm: viewModel)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func tapCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
