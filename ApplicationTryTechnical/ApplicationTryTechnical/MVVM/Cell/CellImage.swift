

import UIKit
import Foundation
import Kingfisher
import Alamofire

class CellImage: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func prepareForReuse() {
        self.imageView.image = UIImage()
        self.authorLabel.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    func setupUI() {
        imageView.layer.cornerRadius = 5
    }
    
    func configCellwithKingfisher(img : Image) {
        let processor = RoundCornerImageProcessor(cornerRadius: 0)
        KF.url(URL(string: img.download_url!)!)
            .placeholder(UIImage(named: img.download_url!))
          .setProcessor(processor)
          .loadDiskFileSynchronously()
          .cacheMemoryOnly()
            .lowDataModeSource(.network(URL(string: img.download_url!)!))
          .onProgress { receivedSize, totalSize in  }
            .onSuccess { result in  print(result.image)}
          .onFailure { error in print(error)}
          .set(to: imageView)
        self.authorLabel.text = img.author
    }
}
