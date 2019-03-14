//
//  AllRestaurentsInCityCell.swift
//  Restaurent Manager
//
//  Created by Viswa Kodela on 3/3/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class AllRestaurentsInCityCell: UICollectionViewCell {
    
    var business: Business? {
        didSet {
            guard let imageurl = business?.image_url, let url = URL(string: imageurl) else {return}
            restaurentImage.sd_setImage(with: url)
            restaurentName.text = business?.name
            locationLabel.text = business?.location?.address1
            
            if business?.is_closed == true {
                let attributedText = NSMutableAttributedString(string: "close", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)])
                isOpenLabel.attributedText = attributedText
                
            } else {
                let attributedText = NSMutableAttributedString(string: "open", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)])
                isOpenLabel.attributedText = attributedText
            }
            
            if business?.rating == 0 {
                ratingImageView.image = UIImage(named: "large_0")
            } else if business?.rating == 0.5 {
                ratingImageView.image = #imageLiteral(resourceName: "yelp_stars_one_small")
            } else if business?.rating == 1 {
                ratingImageView.image = UIImage(named: "large_1")
            } else  if business?.rating == 1.5 {
                ratingImageView.image = UIImage(named: "large_1_half")
            } else  if business?.rating == 2 {
                ratingImageView.image = UIImage(named: "large_2")
            } else  if business?.rating == 2.5 {
                ratingImageView.image = UIImage(named: "large_2_half")
            } else  if business?.rating == 3 {
                ratingImageView.image = UIImage(named: "large_3")
            } else  if business?.rating == 3.5 {
                ratingImageView.image = UIImage(named: "large_3_half")
            } else  if business?.rating == 4 {
                ratingImageView.image = UIImage(named: "large_4")
            } else  if business?.rating == 4.5 {
                ratingImageView.image = UIImage(named: "large_4_half")
            } else {
                ratingImageView.image = UIImage(named: "large_5")
            }
            
            numberOfRatings.text = "\(Int(business?.review_count ?? 0)) ratings"
            phoneNumberLabel.text = "\(business?.display_phone ?? "")"
            categorieslabel.text = "\(business?.categories?[0].title ?? "")"
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLaout()
    }
    
    let restaurentImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let restaurentName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = "Restaurent Name"
        return label
    }()
    
    let numberOfRatings: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "555"
        return label
    }()
    
    let ratingImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
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
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let isOpenLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Open"
        return label
    }()
    
    let phoneNumberLabel: UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let categorieslabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    func setupLaout() {
        
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 1.2
        
        backgroundColor = .white
        
        let locationHorizontalStackView = UIStackView(arrangedSubviews: [locationImageView, locationLabel])
        locationHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        locationHorizontalStackView.axis = .horizontal
        locationHorizontalStackView.spacing = 5
        
        let vericalStackView = UIStackView(arrangedSubviews: [restaurentName, locationHorizontalStackView, isOpenLabel, ratingImageView, numberOfRatings, phoneNumberLabel, categorieslabel])
        vericalStackView.translatesAutoresizingMaskIntoConstraints = false
        vericalStackView.axis = .vertical
        vericalStackView.spacing = 4
        
        
        let overallStackView = UIStackView(arrangedSubviews: [restaurentImage, vericalStackView])
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        overallStackView.axis = .horizontal
        overallStackView.spacing = 5
        overallStackView.alignment = .top
        
        restaurentImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        restaurentImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        ratingImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        ratingImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        restaurentName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        isOpenLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        categorieslabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(overallStackView)
        overallStackView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        overallStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        overallStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
        overallStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
