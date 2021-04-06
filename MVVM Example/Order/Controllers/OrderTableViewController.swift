//
//  OrderTableViewController.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/03/29.
//

//에러해결

import UIKit

class OrderTableViewController: UITableViewController {
    
    var orderListViewModel = OrderListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        populateOrders()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nav = segue.destination as? UINavigationController,
              let addOrderVC = nav.viewControllers.first as? AddViewController else {
            fatalError()
        }
        addOrderVC.delegate = self
    }
    
    private func populateOrders() {
        
        Webservice().load(resource: Order.all) { [weak self](result) in
            switch result {
            case .success(let orders) :
                self?.orderListViewModel.ordersViewModel = orders.filter{$0.type != nil}.map(OrderViewModel.init)
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

extension OrderTableViewController:AddOrderDelegate {
    
    func addOrderViewControllerDidSave(order: Order, controller: UIViewController) {

        controller.dismiss(animated: true, completion: nil)
        let orderViewModel = OrderViewModel(order: order)
        self.orderListViewModel.ordersViewModel.append(orderViewModel)
        self.tableView.insertRows(at: [IndexPath.init(row: self.orderListViewModel.ordersViewModel.count-1, section: 0)], with: .automatic)
    }
    
    func addOrderViewControllerDidClose(contrlloer: UIViewController) {
        contrlloer.dismiss(animated: true, completion: nil)
    }
    
}
