//
//  PropertyCollectionViewCell.swift
//  FolledoRealEstateApp
//
//  Created by Samuel Folledo on 10/17/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class PropertyCollectionViewCell: UICollectionViewCell { //RE ep.29 5mins
    
    
    
    
    
    @IBOutlet weak var imageView: UIImageView! //RE ep.29 6mis
    @IBOutlet weak var topAdImageView: UIImageView! //RE ep.29 13mins
    @IBOutlet weak var soldImageView: UIImageView! //RE ep.29 14mins
    
    @IBOutlet weak var titleLabel: UILabel! //RE ep.29 7mins
    @IBOutlet weak var starButton: UIButton! //RE ep.29 7mins
    
    @IBOutlet weak var roomLabel: UILabel! //RE ep.29 8mins
    @IBOutlet weak var bathroomLabel: UILabel! //RE ep.29 8mins
    @IBOutlet weak var parkingLabel: UILabel! //RE ep.29 8mins
    @IBOutlet weak var priceLabel: UILabel! //RE ep.29 8mins
    
    @IBOutlet weak var loadingIndicator: NSLayoutConstraint! //RE ep.29 14mins
    
    
//generateCell
    func generateCell(property: Property) { //RE ep.30 0mins generate cell will have title, checks if its topAd or Sold property, with image, rooms, bathrooms, parking, and price //RE ep.32 6mins property type changed from String to Property class
        
        titleLabel.text = property.title //RE ep.32 7mins
        roomLabel.text = "\(property.numberOfRooms)" //RE ep.32 7mins
        bathroomLabel.text = "\(property.numberOfBathrooms)" //RE ep.32 8mins
        parkingLabel.text = "\(property.parking)" //RE ep.32 8mins
        
        priceLabel.text = "\(property.price)" //RE ep.32 9mins
        priceLabel.sizeToFit() //RE ep.32 9mins resizes view to fit
        
        
    }
    
    
    @IBAction func starButtonTapped(_ sender: Any) { //RE ep.29 9mins
        
        
    }
    
}
