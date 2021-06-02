//
//  WeatherDataSource.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/06/02.
//

import UIKit

class WeatherDataSource: NSObject,UITableViewDataSource {
    
    let cellIdentifier:String = "WeatherCell"
    private var weatherListViewModel:WeatherListViewModel
    
    init(weatherListViewModel:WeatherListViewModel) {
        self.weatherListViewModel = weatherListViewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherListViewModel.weatherViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier,for: indexPath) as? WeatherCell else { fatalError("\(self.cellIdentifier) not found")}
        
        let weatherVM = self.weatherListViewModel.modelAt(index: indexPath.row)
        cell.cityName.text = weatherVM.name.value
        cell.temperature.text = String(weatherVM.currentTemperature.temperature.value)
        
        return cell
    }
}
