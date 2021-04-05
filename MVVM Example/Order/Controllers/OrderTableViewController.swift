//
//  OrderTableViewController.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/03/29.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    var orderListViewModel = OrderListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        populateOrders()
    }
    
    private func populateOrders() {
        guard let coffeeOrdersURL = URL(string: "http://guarded-retreat-82533.herokuapp.com/orders") else { fatalError() }
        
        let resource = Resource<[Order]>(url:coffeeOrdersURL)
        
        
        
        Webservice().load(resource: resource) { [weak self](result) in
            switch result {
            case .success(let orders) :
                self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
            
        }
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.orderListViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel = self.orderListViewModel.orderViewModel(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell",for: indexPath)
        
        cell.textLabel?.text = viewModel.type
        cell.detailTextLabel?.text = viewModel.size
        
        return cell
    }

}
