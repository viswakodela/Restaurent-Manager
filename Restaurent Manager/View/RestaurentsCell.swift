//
//  RestaurentsCell.swift
//  Restaurent Manager
//
//  Created by Viswa Kodela on 3/2/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class RestaurentsCell: UICollectionViewCell {
    
    var restaurents: [Business]? {
        didSet {
            guard let businesses = self.restaurents else {return}
            horizontalCollectionView.businesses = businesses
            horizontalCollectionView.collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Near to you"
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
    
    let horizontalCollectionView = HorizontalCollectionController()
    
    func setupLayout() {
        
        guard let collectionView = horizontalCollectionView.view else {return}
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
//        titleLabel.backgroundColor = .red
//        seeAllButton.backgroundColor = .blue
        
        addSubview(seeAllButton)
        seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        seeAllButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        seeAllButton.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        seeAllButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = .gray
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(seperatorView)
        seperatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        seperatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 0.2).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

