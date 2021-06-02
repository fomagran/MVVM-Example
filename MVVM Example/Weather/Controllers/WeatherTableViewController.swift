//
//  WeatherTableViewController.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/05/04.
//

import UIKit

class WeatherTableViewController: UITableViewController,AddWeatherDelegate,SettingDelegate {

    let userDefaults = UserDefaults.standard
    private var weatherListViewModel = WeatherListViewModel()
    private var lastUnitSelection:Unit?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let value = userDefaults.value(forKey: "unit") as? String {
            self.lastUnitSelection = Unit(rawValue: value)!
        }
    }
    
    func addWeatherDidSave(vm: WeatherViewModel) {
        weatherListViewModel.addWeatherViewModel(vm: vm)
        self.tableView.reloadData()
    }
    
    func settingDone(vm: SettingViewModel) {
        if lastUnitSelection?.rawValue != vm.selectedUnit.rawValue {
            weatherListViewModel.updateUnit(to:vm.selectedUnit)
            tableView.reloadData()
            lastUnitSelection = Unit(rawValue: vm.selectedUnit.rawValue)
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return weatherListViewModel.numberOfRows(section: section)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        let vm = weatherListViewModel.modelAt(index: indexPath.row)
        cell.configure(vm: vm)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddWeatherViewController" {
            prepareSegueForAddWeatherViewController(segue: segue)
        }else if segue.identifier == "showSettingViewController" {
            prepareSegueForSettingViewController(segue: segue)
        }
    }
    
    func prepareSegueForSettingViewController(segue:UIStoryboardSegue) {
        guard let nav = segue.destination as? UINavigationController else { fatalError() }
    
        guard let settingVC = nav.viewControllers.first as? SettingTableViewController else { fatalError() }
        
        settingVC.delegate = self
        
    }
    
    //네비게이션에 임베드 되어있는 컨트롤러 프로퍼티 접근하기
    func prepareSegueForAddWeatherViewController(segue:UIStoryboardSegue) {
        guard let nav = segue.destination as? UINavigationController else { fatalError() }
        
        guard let addWeatherVC = nav.viewControllers.first as? AddWeatherViewController else { fatalError() }
    
        addWeatherVC.delegate = self
        
        
    }
}
