//
//  OrderViewModel.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/04/05.
//

import Foundation

class OrderListViewModel {
    var ordersViewModel:[OrderViewModel]
    
    init() {
        self.ordersViewModel = [OrderViewModel]()
    }
}

extension OrderListViewModel {
    
    func orderViewModel(at index:Int) -> OrderViewModel {
        return self.ordersViewModel[index]
    }
}

struct OrderViewModel {
    let order:Order
}

extension OrderViewModel {
    var name:String {
        return self.order.name  ?? ""
    }
    
    var email:String {
        return self.order.email ?? ""
    }
    
    var type:String {
        return self.order.type?.rawValue.capitalized ?? ""
    }
    
    var size:String {
        return self.order.size?.rawValue.capitalized ?? ""
    }
}

extension Order {
    
    static var all:Resource<[Order]> = {
        let url = URL(string: "http://guarded-retreat-82533.herokuapp.com/orders")!
        return Resource<[Order]>(url: url)
    }()
    
    static func create(viewModel:AddOrderViewModel) -> Resource<Order?> {
        let order = Order(viewModel)
        let url = URL(string: "http://guarded-retreat-82533.herokuapp.com/orders")!
        
        guard let data = try? JSONEncoder().encode(order) else {fatalError()}
        
        var resource = Resource<Order?>(url: url)
        resource.httpMethod = HTTPMethod.post
        resource.body = data
        
        return resource
    }
}

extension Order {
    init?(_ viewModel:AddOrderViewModel) {
        guard let name = viewModel.name,
              let email = viewModel.email,
              let selectedType = CoffeeType(rawValue: viewModel.selectedType!.lowercased()),
              let selectedSize = CoffeeSize(rawValue: viewModel.selectedSize!.lowercased()) else {return nil}
        self.name = name
        self.email = email
        self.type = selectedType
        self.size = selectedSize
    }
}
