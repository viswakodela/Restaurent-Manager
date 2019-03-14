//
//  SecondHorizontalCell.swift
//  Restaurent Manager
//
//  Created by Viswa Kodela on 3/3/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class SecondHorizontalCell: UICollectionViewCell {
    
    let secondHorizontalCollectionView = SecondHorizontalController()
    
    var businesses: [Business]? {
        didSet {
            guard let location = businesses?.first?.location?.city else {return}
            titleLabel.text = "Restaurents in \(location)"
            guard let businesses = businesses else {return}
            secondHorizontalCollectionView.businesses = businesses
            secondHorizontalCollectionView.collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SeeAll", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return button
    }()
    
    func setupLayout() {
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(seeAllButton)
        seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        seeAllButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        seeAllButton.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        seeAllButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        guard let collectionView = secondHorizontalCollectionView.view else {return}
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
