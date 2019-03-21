//
//  BottomSheetController.swift
//  Restaurent Manager
//
//  Created by Viswa Kodela on 3/19/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class BottomSheetController: UICollectionViewController {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    private let bottomSheetCellID = "bottomSheetCellID"
    
    //MARK:- gesture variables
    var fullView: CGFloat = 100
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 150
    }
    
    var businesses = [Business]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3) {
            let frame = self.view.frame
            let yComponent = self.partialView
            self.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height - 100)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func collectionViewSetup() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePullUpGesture))
        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: bottomSheetCellID)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK:- CollectionView Delegate and DataSource Methods
extension BottomSheetController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.businesses.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bottomSheetCellID, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 200
        return CGSize(width: UIScreen.main.bounds.width, height: height)
    }
}


//MARK:- Pan Gesture delegate and related methods
extension BottomSheetController: UIGestureRecognizerDelegate {
    
    @objc func handlePullUpGesture(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: self.view)
        let velocity = gesture.velocity(in: self.view)
        
        let y = self.view.frame.minY
        
        if (y + translation.y >= fullView) && (y + translation.y <= partialView) {
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            gesture.setTranslation(.zero, in: self.view)
        }
        
        
        self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
        gesture.setTranslation(.zero, in: self.view)
        
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                
                if velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                }
                
            }) { (_) in
                if (velocity.y < 0) {
                    self.collectionView.isScrollEnabled = true
                }
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let gesture = (gestureRecognizer as! UIPanGestureRecognizer)
        let direction = gesture.velocity(in: view).y
        
        
        let y = view.frame.minY
        if (y == fullView && collectionView.contentOffset.y == 0 && direction > 0) || (y == partialView) {
            collectionView.isScrollEnabled = false
        } else {
            collectionView.isScrollEnabled = true
        }
        return false
    }
    
}
