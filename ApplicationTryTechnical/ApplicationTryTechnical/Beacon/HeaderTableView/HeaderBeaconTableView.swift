//
//  HeaderBeaconTableView.swift
//  ApplicationTryTechnical
//
//  Created by Edward Lauv on 1/27/21.
//

import Foundation
import UIKit

protocol HeaderBeaconTableViewDelegate {
    func additem()
}
class HeaderBeaconTableView : UIView {
    @IBOutlet var headerView: UIView!
    var delegate : HeaderBeaconTableViewDelegate!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSupview()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSupview()
    }
    
    func initSupview() {
        let nib = UINib(nibName: "HeaderBeaconTableView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        headerView.frame = bounds
        addSubview(headerView)
    }
    @IBAction func additem(_ sender: Any) {
        delegate.additem()
    }
}
