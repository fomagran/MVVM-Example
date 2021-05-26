//
//  WeatherTableViewController.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/05/04.
//

import UIKit

class WeatherTableViewController: UITableViewController,AddWeatherDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func addWeatherDidSave(vm: WeatherViewModel) {
        print(vm)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddWeatherViewController" {
            
        }
    }
    
    //네비게이션에 임베드 되어있는 컨트롤러 프로퍼티 접근하기
    func prepareSegueForAddWeatherViewController(segue:UIStoryboardSegue) {
        guard let nav = segue.destination as? UINavigationController else { fatalError() }
        
        guard let addWeatherVC = nav.viewControllers.first as? AddWeatherViewController else { fatalError() }
        
        addWeatherVC.delegate = self
        
    }
}
