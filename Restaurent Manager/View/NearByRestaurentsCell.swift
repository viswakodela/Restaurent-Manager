//
//  HorizontalCell.swift
//  Restaurent Manager
//
//  Created by Viswa Kodela on 3/3/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
import SDWebImage

class NearByRestaurentsCell: UICollectionViewCell {
    
    var restaurent: Business? {
        didSet {
            guard let imgeUrl = restaurent?.image_url, let url = URL(string: imgeUrl) else {return}
            restaurentImage.sd_setImage(with: url)
            priceLabel.text = restaurent?.price ?? "N/A"
            
            restaurentName.text = restaurent?.name
            
            if restaurent?.is_closed == false {
                isOpenLabel.attributedText = NSMutableAttributedString(string: "Open", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)])
            } else {
                isOpenLabel.attributedText = NSMutableAttributedString(string: "Closed", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)])
            }
            
            if restaurent?.rating == 0 {
                ratingsImageView.image = UIImage(named: "large_0")
            } else if restaurent?.rating == 0.5 {
                ratingsImageView.image = #imageLiteral(resourceName: "yelp_stars_one_small")
            } else if restaurent?.rating == 1 {
                ratingsImageView.image = UIImage(named: "large_1")
            } else  if restaurent?.rating == 1.5 {
                ratingsImageView.image = UIImage(named: "large_1_half")
            } else  if restaurent?.rating == 2 {
                ratingsImageView.image = UIImage(named: "large_2")
            } else  if restaurent?.rating == 2.5 {
                ratingsImageView.image = UIImage(named: "large_2_half")
            } else  if restaurent?.rating == 3 {
                ratingsImageView.image = UIImage(named: "large_3")
            } else  if restaurent?.rating == 3.5 {
                ratingsImageView.image = UIImage(named: "large_3_half")
            } else  if restaurent?.rating == 4 {
                ratingsImageView.image = UIImage(named: "large_4")
            } else  if restaurent?.rating == 4.5 {
                ratingsImageView.image = UIImage(named: "large_4_half")
            } else {
                ratingsImageView.image = UIImage(named: "large_5")
            }
            
            guard let distance = restaurent?.distance else {return}
            let distanceInKM = distance * 0.001
            let distanceString = String(format: "%.2f", distanceInKM)
            locationlabel.text = "\(distanceString)km"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    let restaurentImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let isOpenLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Open"
        label.textColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return label
    }()
    
    let locationImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "maps-and-flags")
        iv.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return iv
    }()
    
    let locationlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$$$"
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return label
    }()
    
    let restaurentName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let ratingsImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    func setupLayout() {
        
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 4
        
        backgroundColor = .white
        
        addSubview(restaurentImage)
        restaurentImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        restaurentImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        restaurentImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        restaurentImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65).isActive = true
        
        let horizontalStackView = UIStackView(arrangedSubviews: [priceLabel, isOpenLabel, locationImageView, locationlabel])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 4
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(horizontalStackView)
        horizontalStackView.topAnchor.constraint(equalTo: restaurentImage.bottomAnchor, constant: 2).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        horizontalStackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(ratingsImageView)
        ratingsImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        ratingsImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        ratingsImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        ratingsImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(restaurentName)
        restaurentName.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor).isActive = true
        restaurentName.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        restaurentName.trailingAnchor.constraint(equalTo: ratingsImageView.leadingAnchor).isActive = true
        restaurentName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 1).isActive = true
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
