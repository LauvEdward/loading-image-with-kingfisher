//
//  TapBar.swift
//  ApplicationTryTechnical
//
//  Created by Edward Lauv on 1/27/21.
//

import Foundation
import UIKit
class CustomTabbarController : UITabBarController, UITabBarControllerDelegate {
    var imageviewController : ImageViewController!
    var beaconviewController : BeaconViewController!
    override func viewDidLoad() {
        self.delegate = self
        
        imageviewController = ImageViewController()
        imageviewController.tabBarItem.image = UIImage(systemName: "photo.on.rectangle.angled")
        imageviewController.tabBarItem.selectedImage = UIImage(systemName: "photo.on.rectangle.fill")
        imageviewController.tabBarItem.title = "Library"
        
        beaconviewController = BeaconViewController()
        beaconviewController.tabBarItem.image = UIImage(systemName: "iphone.homebutton.radiowaves.left.and.right")
        beaconviewController.tabBarItem.title = "Beacon"
        
        viewControllers = [beaconviewController, imageviewController]
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: CustomTabbarController.self) {
            let vc = CustomTabbarController()
            vc.modalPresentationStyle = .fullScreen
            vc.present(vc, animated: true, completion: nil)
            return false
        }
        return true
    }
}
