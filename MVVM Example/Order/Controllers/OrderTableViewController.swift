//
//  OrderTableViewController.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/03/29.
//

import UIKit

class OrderTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        populateOrders()
    }
    
    private func populateOrders() {
        guard let coffeeOrdersURL = URL(string: "http://guarded-retreat-82533.herokuapp.com/orders") else { fatalError() }
        
        let resource = Resource<[Order]>(url:coffeeOrdersURL)
        
        
        
        Webservice().load(resource: resource) { (result) in
            switch result {
            case .success(let orders) :
                print(orders)
            case .failure(let error):
                print(error)
            }
            
        }
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0
    }

}
