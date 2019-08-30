//
//  PropertyCellTableViewCell.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 29/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit
import Domain
import Kingfisher

class PropertyCellTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.layer.cornerRadius = 5
            thumbnailImageView.layer.masksToBounds = true
            thumbnailImageView.backgroundColor = Colors.ImageDefaultBackgroundColor
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeButton: UIButton! {
        didSet {
            typeButton.layer.borderWidth = 2
            typeButton.layer.cornerRadius = 5
            typeButton.layer.masksToBounds = true
            typeButton.isUserInteractionEnabled = false
        }
    }
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView! {
        didSet {
            starImageView.tintColor = Colors.RatingStarColor
            starImageView.image = UIImage(named: "icon-star", in: Bundle(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    var property: PropertySummary! {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        if let imageUrl = URL(string: property.thumbnailUrl) {
            thumbnailImageView.kf.setImage(with: imageUrl)
        }
        
        if let rating = property.rating {
            starImageView.isHidden = false
            ratingLabel.text = String(format: "%.2f", rating)
        }
        
        typeButton.isHidden = property.propertyType == .unknown
        typeButton.setTitle(property.propertyType.rawValue.capitalized, for: .normal)
        nameLabel.text = property.name
        
        switch property.propertyType {
        case .apartment:
            typeButton.setTitleColor(Colors.ApartmentPropertyTypeColor, for: .normal)
            typeButton.layer.borderColor = Colors.ApartmentPropertyTypeColor.cgColor
        case .guestHouse:
            typeButton.setTitleColor(Colors.GuestHousePropertyTypeColor, for: .normal)
            typeButton.layer.borderColor = Colors.GuestHousePropertyTypeColor.cgColor
        case .hotel:
            typeButton.setTitleColor(Colors.HotelPropertyTypeColor, for: .normal)
            typeButton.layer.borderColor = Colors.HotelPropertyTypeColor.cgColor
        case .hostel:
            typeButton.setTitleColor(Colors.HostelPropertyTypeColor, for: .normal)
            typeButton.layer.borderColor = Colors.HostelPropertyTypeColor.cgColor
        case .unknown:
            typeButton.isHidden = true
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        starImageView.isHidden = true
        typeButton.isHidden = true
        ratingLabel.text = nil
    }
    
}
