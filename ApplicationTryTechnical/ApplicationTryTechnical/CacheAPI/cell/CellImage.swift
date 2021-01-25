

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
    
    func configCellwithKingfisher(image : Image) {
        //self.imageView.kf.setImage(with: URL(string: (image.download_url!)))
        self.imageView.kf.setImage(with: URL(string: image.download_url!), placeholder: UIImage(named: image.download_url!),
                                   options: [.cacheOriginalImage,.transition(.fade(1))]) { (result) in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
        }
        self.authorLabel.text = image.author
    }
}
