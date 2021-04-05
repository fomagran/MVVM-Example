//
//  AddViewController.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/03/29.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    private var viewModel = AddOrderViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension AddViewController:UITableViewDelegate {
    
}

extension AddViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "AddOrderTableViewCell",for:indexPath)
        cell.textLabel?.text = self.viewModel.types[indexPath.row]
        return cell
    }
    
    
}
