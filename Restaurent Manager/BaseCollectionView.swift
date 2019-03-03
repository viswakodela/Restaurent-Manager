//
//  BaseCollectionView.swift
//  Restaurent Manager
//
//  Created by Viswa Kodela on 3/3/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class BaseCollectionView: UICollectionViewController {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
