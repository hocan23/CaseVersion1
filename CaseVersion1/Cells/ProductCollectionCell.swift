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
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
  let myLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    var priceLbl: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(red: 45/255, green: 49/255, blue: 245/255, alpha: 1)
        return label
      }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(myLabel)
        contentView.addSubview(priceLbl)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.anchor(top: contentView.topAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: contentView.frame.height*0.6)
        myLabel.anchor(top: imageView.bottomAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 5, paddingRight: 0, width: 0, height: contentView.frame.height*0.2)
        priceLbl.anchor(top: myLabel.bottomAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 5, paddingRight: 0, width: 0, height: contentView.frame.height*0.2)
    }
    
    public func configure(label: String){
        myLabel.text = label
    }
}
