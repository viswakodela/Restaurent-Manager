//
//  RestaurentsCell.swift
//  Restaurent Manager
//
//  Created by Viswa Kodela on 3/2/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class RestaurentsCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is the Header"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let horizontalCollectionView = HorizontalCollectionController()
    
    func setupLayout() {
        
        guard let collectionView = horizontalCollectionView.view else {return}
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
