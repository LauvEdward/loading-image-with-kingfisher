//
//  BeaconViewController.swift
//  ApplicationTryTechnical
//
//  Created by Edward Lauv on 1/27/21.
//

import UIKit
import CoreLocation

class BeaconViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let locationManager = CLLocationManager()
    let item = [Item]()
    var datasource : CustomTableViewDataSource<BeaconCell, Item>!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI() {
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "BeaconCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.datasource = CustomTableViewDataSource(indentifier: "cell", listitem: item, config: { (cell, item) in
            cell.item = item
        })
    }
}

extension BeaconViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderBeaconTableView()
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension BeaconViewController : HeaderBeaconTableViewDelegate {
    func additem() {
        let additemVC = AddItemBeaconViewController()
        additemVC.providesPresentationContextTransitionStyle = true
        additemVC.definesPresentationContext = true
        additemVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        additemVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(additemVC, animated: true, completion: nil)
    }
}

extension BeaconViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        
    }
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Failed monitoring region: \(error.localizedDescription)")
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      print("Location manager failed: \(error.localizedDescription)")
    }
}
