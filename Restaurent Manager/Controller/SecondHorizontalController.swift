//
//  SecondHorizontalController.swift
//  Restaurent Manager
//
//  Created by Viswa Kodela on 3/3/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class SecondHorizontalController: BaseCollectionView {
    
    private static let allRestaurentsCellID = "allRestaurentsCellID"
    
    var businesses = [Business]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewLayout()
    }
    
    func collectionViewLayout() {
        collectionView.backgroundColor = .white
        collectionView.register(AllRestaurentsInCityCell.self, forCellWithReuseIdentifier: SecondHorizontalController.allRestaurentsCellID)
    }
}


//MARK:- CollectionView Delegate and DataSource methods
extension SecondHorizontalController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(10,businesses.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondHorizontalController.allRestaurentsCellID, for: indexPath) as! AllRestaurentsInCityCell
        cell.business = businesses[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.height - 10
        return CGSize(width: view.frame.width - 100, height: height)
    }
    
}
