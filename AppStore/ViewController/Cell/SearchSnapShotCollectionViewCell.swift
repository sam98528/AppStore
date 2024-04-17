//
//  SearchSnapShotCollectionViewCell.swift
//  AppStore
//
//  Created by Sam.Lee on 4/17/24.
//

import UIKit
import Kingfisher

class SearchSnapShotCollectionViewCell: UICollectionViewCell {

    static let identifier = "SearchSnapShotCollectionViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "SearchSnapShotCollectionViewCell", bundle: nil)
    }
    
    @IBOutlet weak var snapShotImageView: UIImageView!
    
    override func prepareForReuse() {
        self.snapShotImageView.image = nil
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with urlString: String){
        let roudingProcessor = RoundCornerImageProcessor(cornerRadius: 30,backgroundColor: .clear)
        self.snapShotImageView.kf.setImage(
            with: URL(string: urlString),
            options: [
                //.processor(resizingProcessor),
                .processor(roudingProcessor)
                
            ]
        )
    }
}
