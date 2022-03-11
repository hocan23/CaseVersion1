//
//  ProductCollectionCell.swift
//  CaseVersion1
//
//  Created by Hasan onur Can on 10.03.2022.
//

import Foundation
import UIKit

class ProductCollectionCell: UICollectionViewCell{
    static let identifier = "CollectionCell"
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "house")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        return image
    }()
  let myLabel: UILabel = {
        let label = UILabel()
        label.text = "hasan baba"
        label.textAlignment = .left
        return label
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(myLabel)
        contentView.clipsToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        myLabel.frame = CGRect(x: 5, y: contentView.frame.size.height-50, width: contentView.frame.size.width-10, height: 50)
        imageView.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width-10, height: contentView.frame.size.height-50)
    }
    public func configure(label: String){
        myLabel.text = label
    }
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        myLabel.text = nil
//    }
}
