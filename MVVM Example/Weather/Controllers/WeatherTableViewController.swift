//
//  WeatherTableViewController.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/05/04.
//

import UIKit

class WeatherTableViewController: UITableViewController,AddWeatherDelegate,SettingDelegate {

    let userDefaults = UserDefaults.standard
    
    private var datasource:TableViewDataSource<WeatherCell,WeatherViewModel>!
    private var weatherListViewModel = WeatherListViewModel()
    private var lastUnitSelection:Unit?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datasource = TableViewDataSource(cellIdentifier: "WeatherCell", viewModels: weatherListViewModel.weatherViewModels) { cell, vm in
            cell.cityName.text = vm.name.value
            cell.temperature.text = String(vm.currentTemperature.temperature.value)
        }
        self.tableView.dataSource = self.datasource
        
        if let value = userDefaults.value(forKey: "unit") as? String {
            self.lastUnitSelection = Unit(rawValue: value)!
        }
    }
    
    func addWeatherDidSave(vm: WeatherViewModel) {

        weatherListViewModel.addWeatherViewModel(vm: vm)
        self.datasource.updateViewModels(weatherListViewModel.weatherViewModels)
        self.tableView.reloadData()
    }
    
    func settingDone(vm: SettingViewModel) {
        if lastUnitSelection?.rawValue != vm.selectedUnit.rawValue {
            weatherListViewModel.updateUnit(to:vm.selectedUnit)
            tableView.reloadData()
            lastUnitSelection = Unit(rawValue: vm.selectedUnit.rawValue)
        }
        
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showWeatherDetailViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddWeatherViewController" {
            prepareSegueForAddWeatherViewController(segue: segue)
        }else if segue.identifier == "showSettingViewController" {
            prepareSegueForSettingViewController(segue: segue)
        }else if segue.identifier == "showWeatherDetailViewController" {
            prepareSegueForWeatherDetailViewController(segue: segue)
        }
    }
    
    func prepareSegueForSettingViewController(segue:UIStoryboardSegue) {
        guard let nav = segue.destination as? UINavigationController else { fatalError() }
    
        guard let settingVC = nav.viewControllers.first as? SettingTableViewController else { fatalError() }
        
        settingVC.delegate = self
        
    }
    
    //?????????????????? ????????? ???????????? ???????????? ???????????? ????????????
    func prepareSegueForAddWeatherViewController(segue:UIStoryboardSegue) {
        guard let nav = segue.destination as? UINavigationController else { fatalError() }
        
        guard let addWeatherVC = nav.viewControllers.first as? AddWeatherViewController else { fatalError() }
    
        addWeatherVC.delegate = self
    }
    
    func prepareSegueForWeatherDetailViewController(segue:UIStoryboardSegue) {
        
        guard let weatherDetailVC = segue.destination as? WeatherDetailViewController,let indexPath = self.tableView.indexPathForSelectedRow else { return }
    
        let weatherVM = self.weatherListViewModel.modelAt(index: indexPath.row)
        weatherDetailVC.weatherViewModel = weatherVM
    }
    
    
}
