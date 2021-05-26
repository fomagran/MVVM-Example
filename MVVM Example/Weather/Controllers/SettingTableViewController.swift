//
//  SettingTableViewController.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/05/26.
//

import UIKit

class SettingTableViewController: UITableViewController {
    private var settingsViewModel = SettingViewModel()
    
    override func viewDidLoad() {
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.units.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingItem = settingsViewModel.units[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell",for: indexPath)
        cell.textLabel?.text = settingItem.displayName
        return cell
    }
}
