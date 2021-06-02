//
//  TableViewDataSource.swift
//  MVVM Example
//
//  Created by Fomagran on 2021/06/02.
//

import UIKit

class TableViewDataSource<CellType,ViewModel>:NSObject,UITableViewDataSource where CellType:UITableViewCell{
    
    let cellIdentifier:String
    var viewModels:[ViewModel]
    let configureCell:(CellType,ViewModel) -> ()
    
    init(cellIdentifier:String,viewModels:[ViewModel],configureCell:@escaping (CellType,ViewModel) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.viewModels = viewModels
        self.configureCell = configureCell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier,for: indexPath) as? CellType else { fatalError("No Cell Indentifer: \(self.cellIdentifier)")}
        
        let vm = self.viewModels[indexPath.row]
        self.configureCell(cell,vm)
        
        return cell
    }
    
    func updateViewModels(_ viewModels:[ViewModel]) {
        self.viewModels = viewModels
    }
    
}

