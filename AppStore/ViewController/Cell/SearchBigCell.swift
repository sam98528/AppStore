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
        //let processor = RoundCornerImageProcessor(cornerRadius: 150,backgroundColor: .clear)
        self.iconImageView.kf.setImage(with: URL(string: data?.appIconImage ?? ""))
        self.iconImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        self.iconImageView.layer.borderWidth = 1
        self.iconImageView.layer.cornerRadius = 15
        self.titleLabel.text = data?.appTitle
        self.subTitleLabel.text = data?.primaryGenreName
        self.genreLabel.text = data?.primaryGenreName
        
        
        
        self.ratingLabel.attributedText = makeStarLabel(rating: data?.averageUserRating ?? 0.0, count: data?.userRatingCount ?? 0)
        self.developerLabel.attributedText = makeDeveloperLabel(artistName: data?.artistName ?? "")
        self.downloadButton.layer.cornerRadius = self.downloadButton.bounds.height / 2
    }
    
    func makeStarLabel(rating : Double, count: Int) -> NSMutableAttributedString{
        let attributeString = NSMutableAttributedString(string: "")
        
        // 별 이미지를 추가합니다.
        let fullStarCount = Int(rating)
        for _ in 0..<fullStarCount {
            let imageAttachment = NSTextAttachment(image: UIImage(systemName: "star.fill")!)
            imageAttachment.bounds = .init(x: 0, y: -2, width: 14, height: 14)
            attributeString.append(NSAttributedString(attachment: imageAttachment))
        }
        
        // 소수점 이하의 값을 반올림하여 추가합니다.
        let remainingRating = rating - Double(fullStarCount)
        if remainingRating > 0 {
            let imageAttachment = NSTextAttachment(image: UIImage(systemName: "star.leadinghalf.fill")!)
            imageAttachment.bounds = .init(x: 0, y: -2, width: 14, height: 14)
            attributeString.append(NSAttributedString(attachment: imageAttachment))
        }
        
        // 나머지 빈 별을 추가합니다.
        let emptyStarCount = 5 - fullStarCount - (remainingRating > 0 ? 1 : 0)
        for _ in 0..<emptyStarCount {
            let imageAttachment = NSTextAttachment(image: UIImage(systemName: "star")!)
            imageAttachment.bounds = .init(x: 0, y: -2, width: 14, height: 14)
            attributeString.append(NSAttributedString(attachment: imageAttachment))
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        let numberString: String
        if count > 9999 {
            let number = Double(count) / 10000.0
            numberString = "\(formatter.string(from: NSNumber(value: number))!)만"
        } else if count > 999 {
            let number = Double(count) / 1000.0
            numberString = "\(formatter.string(from: NSNumber(value: number))!)천"
        } else {
            numberString = "\(count)"
        }
        
        attributeString.append(NSAttributedString(string: " \(numberString)"))
        return attributeString
    }
    func makeDeveloperLabel(artistName : String) -> NSMutableAttributedString{
        let attributeString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment(image: UIImage(systemName: "person.crop.square")!)
        imageAttachment.bounds = .init(x: 0, y: -2, width: 15, height: 14)
        attributeString.append(NSAttributedString(attachment: imageAttachment))
        attributeString.append(NSAttributedString(string: " \(artistName)"))
        return attributeString
    }
}


extension SearchBigCell : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.screenshotUrls.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchSnapShotCollectionViewCell.identifier, for: indexPath) as? SearchSnapShotCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(with: data?.screenshotUrls[indexPath.row] ?? "")
        return cell
    }
    
}
