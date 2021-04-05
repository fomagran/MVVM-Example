//
//  AddViewController.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/03/29.
//

import UIKit

protocol AddOrderDelegate {
    func addOrderViewControllerDidSave(order:Order,controller:UIViewController)
    func addOrderViewControllerDidClose(contrlloer:UIViewController)
}

class AddViewController: UIViewController{
  

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var table: UITableView!
    private var viewModel = AddOrderViewModel()
    private var segment:UISegmentedControl!
    var delegate:AddOrderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.segment = UISegmentedControl(items: self.viewModel.sizes)
        self.segment.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.segment)
        self.segment.topAnchor.constraint(equalTo: self.table.bottomAnchor, constant: 20).isActive = true
        self.segment.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive  = true
    }
    @IBAction func tapCloseButton(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.addOrderViewControllerDidClose(contrlloer: self)
        }
    }
    @IBAction func tapSaveButton(_ sender: Any) {
        let name = self.nameTF.text
        let email = self.emailTF.text
        
        let selectedSize = self.segment.titleForSegment(at: self.segment.selectedSegmentIndex)

        guard let indexPath = self.table.indexPathForSelectedRow else {fatalError()}

        self.viewModel.name = name
        self.viewModel.email = email
        self.viewModel.selectedSize = selectedSize
        self.viewModel.selectedType = self.viewModel.types[indexPath.row]
        
        Webservice().load(resource:Order.create(viewModel: self.viewModel)) {
            result in
            switch result {
            case .success(let order):
                if let order = order,let delegate = self.delegate {
                    DispatchQueue.main.async {
                        delegate.addOrderViewControllerDidSave(order: order, controller: self)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension AddViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        table.cellForRow(at: indexPath)?.accessoryType = .none
    }
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

