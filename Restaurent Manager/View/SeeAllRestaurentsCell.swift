//
//  SeeAllRestaurentsCell.swift
//  Restaurent Manager
//
//  Created by Viswa Kodela on 3/13/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class SeeAllRestaurentsCell: UICollectionViewCell {
    
    var business: Business? {
        didSet {
            restaurentName.text = business?.name
            guard let imageString = business?.image_url, let url = URL(string: imageString) else {return}
            restaurentImage.sd_setImage(with: url)
            if business?.is_closed == true {
                let attributedText = NSMutableAttributedString(string: "close", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)])
                isOpenLabel.attributedText = attributedText
                
            } else {
                let attributedText = NSMutableAttributedString(string: "open", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)])
                isOpenLabel.attributedText = attributedText
            }
            
            
            if business?.rating == 0 {
                ratingsImageView.image = UIImage(named: "large_0")
            } else if business?.rating == 0.5 {
                ratingsImageView.image = #imageLiteral(resourceName: "yelp_stars_one_small")
            } else if business?.rating == 1 {
                ratingsImageView.image = UIImage(named: "large_1")
            } else  if business?.rating == 1.5 {
                ratingsImageView.image = UIImage(named: "large_1_half")
            } else  if business?.rating == 2 {
                ratingsImageView.image = UIImage(named: "large_2")
            } else  if business?.rating == 2.5 {
                ratingsImageView.image = UIImage(named: "large_2_half")
            } else  if business?.rating == 3 {
                ratingsImageView.image = UIImage(named: "large_3")
            } else  if business?.rating == 3.5 {
                ratingsImageView.image = UIImage(named: "large_3_half")
            } else  if business?.rating == 4 {
                ratingsImageView.image = UIImage(named: "large_4")
            } else  if business?.rating == 4.5 {
                ratingsImageView.image = UIImage(named: "large_4_half")
            } else {
                ratingsImageView.image = UIImage(named: "large_5")
            }
            
            guard let distance = business?.distance else {return}
            let distanceInKM = distance * 0.001
            let distanceString = String(format: "%.2f", distanceInKM)
            locationlabel.text = "\(distanceString)km"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 16
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
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }()
    
    let locationImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "maps-and-flags")
        iv.widthAnchor.constraint(equalToConstant: 20).isActive = true
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
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .topRight], radius: 16)
    }
    
    func setupLayout() {
        
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 1.5
        
        
        let horizontalStackView = UIStackView(arrangedSubviews: [priceLabel, isOpenLabel, locationImageView, locationlabel, ratingsImageView])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 4
        
        let overallStackView = UIStackView(arrangedSubviews: [restaurentImage, horizontalStackView, restaurentName])
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        overallStackView.axis = .vertical
        overallStackView.spacing = 4
        overallStackView.layer.cornerRadius = 16
        overallStackView.clipsToBounds = true
        
        horizontalStackView.leadingAnchor.constraint(equalTo: overallStackView.leadingAnchor, constant: 5).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: overallStackView.trailingAnchor, constant: -5).isActive = true
        restaurentImage.heightAnchor.constraint(equalToConstant: 130).isActive = true
        restaurentImage.leadingAnchor.constraint(equalTo: overallStackView.leadingAnchor).isActive = true
        restaurentName.leadingAnchor.constraint(equalTo: overallStackView.leadingAnchor, constant: 5).isActive = true
        
        
        addSubview(overallStackView)
        overallStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        overallStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        overallStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        overallStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
