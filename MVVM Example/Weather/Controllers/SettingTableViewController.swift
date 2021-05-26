//
//  SettingTableViewController.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/05/26.
//

import UIKit

protocol SettingDelegate {
    func settingDone(vm:SettingViewModel)
}

class SettingTableViewController: UITableViewController {
    
    var delegate:SettingDelegate?
    
    private var settingsViewModel = SettingViewModel()
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func tapDoneButton(_ sender: Any) {
            delegate?.settingDone(vm: settingsViewModel)
            dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.visibleCells.forEach {
            cell in cell.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at:indexPath) {
            cell.accessoryType = .checkmark
            let unit = Unit.allCases[indexPath.row]
            settingsViewModel.selectedUnit = unit
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at:indexPath) {
            cell.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.units.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingItem = settingsViewModel.units[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell",for: indexPath)
        cell.textLabel?.text = settingItem.displayName
        
        if settingItem == settingsViewModel.selectedUnit {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
}
