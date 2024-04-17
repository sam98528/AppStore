//
//  SearchBigCell.swift
//  AppStore
//
//  Created by Sam.Lee on 4/16/24.
//

import UIKit
import Kingfisher

class SearchBigCell: UITableViewCell {

    @IBOutlet weak var snapShotCollectionView: UICollectionView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    var data : App?
    
    static let identifier = "SearchBigCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "SearchBigCell", bundle: nil)
    }
    
    override func prepareForReuse() {
        self.snapShotCollectionView.reloadData()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionViewConfigure(){
        self.snapShotCollectionView.dataSource = self
        self.snapShotCollectionView.delegate = self
        self.snapShotCollectionView.register(SearchSnapShotCollectionViewCell.nib(), forCellWithReuseIdentifier: SearchSnapShotCollectionViewCell.identifier)
        
        let selectedFlowLayout = UICollectionViewFlowLayout()
        selectedFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        selectedFlowLayout.minimumLineSpacing = 5
        selectedFlowLayout.minimumInteritemSpacing = 0
        selectedFlowLayout.scrollDirection = .horizontal
        selectedFlowLayout.itemSize = CGSize(width: Int(snapShotCollectionView.frame.size.width / 3 - selectedFlowLayout.minimumLineSpacing / 3), height: Int(snapShotCollectionView.frame.size.height))
        snapShotCollectionView.collectionViewLayout = selectedFlowLayout
    }
    func configure(indexPath : IndexPath){
        self.data = SearchResult.data[indexPath.row]
        collectionViewConfigure()
        self.iconImageView.clipsToBounds = true
        let processor = RoundCornerImageProcessor(cornerRadius: 150)
        self.iconImageView.kf.setImage(with: URL(string: data?.appIconImage ?? ""), options: [.processor(processor)])

        self.titleLabel.text = data?.appTitle
        self.subTitleLabel.text = data?.primaryGenreName
        self.genreLabel.text = data?.primaryGenreName
        self.ratingLabel.text = String(format: "%.2f", data?.averageUserRating ?? 0.0)
        self.developerLabel.text = data?.artistName
        self.downloadButton.layer.cornerRadius = self.downloadButton.bounds.height / 2
        //self.snapShotCollectionView.reloadData()
    }
}

extension SearchBigCell : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchSnapShotCollectionViewCell.identifier, for: indexPath) as? SearchSnapShotCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(with: data?.screenshotUrls[indexPath.row] ?? "")
        return cell
    }
    
}
