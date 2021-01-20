//
//  ImageViewController.swift
//  ApplicationTryTechnical
//
//  Created by Edward Lauv on 1/19/21.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let spacing : Int = 5
    var dataImage : [Image] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAPI()
        // Do any additional setup after loading the view.
    }
    func fetchAPI() {
        APImanager.shared.fetchImage { (data) in
            self.dataImage = data
            DispatchQueue.main.async {
                self.setupUI()
            }
        }
    }
    
    func setupUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CellImage", bundle: nil), forCellWithReuseIdentifier: "cell")
    }

}

extension ImageViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellImage
        cell.imageInfor = dataImage[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthcell = (Int(collectionView.bounds.width) - spacing)/2
        return CGSize(width: widthcell, height: widthcell)
    }
}
extension ImageViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(spacing)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(spacing)
    }
}
