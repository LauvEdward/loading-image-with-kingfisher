//
//  TableViewDataSource.swift
//  ApplicationTryTechnical
//
//  Created by Edward Lauv on 1/28/21.
//

import Foundation
import UIKit

class CustomTableViewDataSource <CELL : UITableViewCell, T> : NSObject, UITableViewDataSource {
    var cellIndentifier : String!
    var items : [T]!
    var configCell : (CELL, T) -> () = {_, _ in}
    init(indentifier : String, listitem : [T], config : @escaping (CELL, T) -> ()) {
        cellIndentifier = indentifier
        items = listitem
        configCell = config
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath)
        self.configCell(cell as! CELL, items[indexPath.row])
        return cell
    }
    
}
