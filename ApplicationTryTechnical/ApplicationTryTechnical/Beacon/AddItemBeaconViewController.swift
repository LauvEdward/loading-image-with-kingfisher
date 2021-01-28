//
//  AddItemBeaconViewController.swift
//  ApplicationTryTechnical
//
//  Created by Edward Lauv on 1/27/21.
//

import UIKit

protocol AddItemBeaconDelegate {
    func addItem()
}

class AddItemBeaconViewController: UIViewController {

    @IBOutlet weak var nameUUIDTextfield: UITextField!
    @IBOutlet weak var nameBeaconTextfiled: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var buttonCancle: UIButton!
    
    var delegate : AddItemBeaconDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }


    @IBAction func clickBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func setupUI() {
        backgroundView.layer.cornerRadius = 10
        buttonAdd.layer.cornerRadius = 10
        buttonCancle.layer.cornerRadius = 10
    }
    @IBAction func additem(_ sender: Any) {
        
    }
    @IBAction func cancle(_ sender: Any) {
    }
    
}
