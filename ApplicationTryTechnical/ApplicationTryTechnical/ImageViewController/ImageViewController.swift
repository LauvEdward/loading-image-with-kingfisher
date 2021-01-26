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
    var imageViewModel : ImagesViewModel!
    var datasource : ImageCollectionViewDataSource<CellImage, Image>!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        imageViewModel = ImagesViewModel()
        imageViewModel.bindImageViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource() {
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CellImage", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.datasource = ImageCollectionViewDataSource(cellIdentifier: "cell", items: imageViewModel.empData, configureCell: { (cell, image) in
            cell.configCellwithKingfisher(img: image)
        })
        DispatchQueue.main.async {
            self.collectionView.dataSource = self.datasource
            self.collectionView.reloadData()
        }
    }

}

extension ImageViewController : UICollectionViewDelegate {
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
