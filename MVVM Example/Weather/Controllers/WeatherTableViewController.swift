//
//  WeatherTableViewController.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/05/04.
//

import UIKit

class WeatherTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=\(WeatherKey().key)&units=imperial")!
        let resource = WeatherResource(url: url) { data in
            
           return try? JSONDecoder().decode(WeatherResponse.self, from: data)
        }
        
        WeatherWebService().load(resource: resource) { response in
            if let response = response {
                print(response)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "foma"
        return cell
    }
}
