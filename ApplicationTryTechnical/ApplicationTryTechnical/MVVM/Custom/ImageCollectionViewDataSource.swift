//
//  ImageCollectionViewDataSource.swift
//  ApplicationTryTechnical
//
//  Created by Edward Lauv on 1/26/21.
//

import Foundation
import UIKit
class ImageCollectionViewDataSource <CELL : UICollectionViewCell,T>: NSObject, UICollectionViewDataSource {
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> ()) {
            self.cellIdentifier = cellIdentifier
            self.items =  items
            self.configureCell = configureCell
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        self.configureCell(cell as! CELL, items[indexPath.row])
        return cell
    }
}
