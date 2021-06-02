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

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var zipCodeTF: UITextField!
    
    var delegate:AddWeatherDelegate?
    
    private var addWeatherVM = AddWeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tapSaveButton(_ sender: Any) {
        
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
