//
//  BeaconCell.swift
//  ApplicationTryTechnical
//
//  Created by Edward Lauv on 1/27/21.
//

import UIKit

class BeaconCell: UITableViewCell {

    @IBOutlet weak var namebeaconLabel: UILabel!
    @IBOutlet weak var nameLocationLabel: UILabel!
    
    var item : Item? = nil {
        didSet {
            if item != nil {
                namebeaconLabel.text = item?.name
                nameLocationLabel.text = item?.locationString()
            } else {
                namebeaconLabel.text = ""
                nameLocationLabel.text = ""
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refreshLocation() {
        nameLocationLabel.text = item?.locationString() ?? ""
    }
    
}
