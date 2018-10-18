//
//  RecentViewController.swift
//  FolledoRealEstateApp
//
//  Created by Samuel Folledo on 10/17/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class RecentViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout { //RE ep.29 0mins //RE ep.32 0mins UICVDelegate, UICVDataSource, UICVFlowLayout added
    
    var properties: [Property] = [] //RE ep.32 1min
    
    @IBOutlet weak var collectionView: UICollectionView! //RE ep.29 3mins
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    override func viewWillLayoutSubviews() { //RE ep.32 2mins
        collectionView.collectionViewLayout.invalidateLayout() //RE ep.32 2mins invalidateLayout = Invalidates the current layout and triggers a layout update.
    }
    
    override func viewWillAppear(_ animated: Bool) { //RE ep.32 1min
        //load properties
        loadProperties(limitNumber: kRECENTPROPERTYLIMIT) //RE ep.33 8mins load properties with limit. If user didnt put any number, limit it by default of 20
    }
    
    
//MARK: CollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { //RE ep.32 3mins how many items in 1 section
        return properties.count //RE ep.32 4mins
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { //RE ep.32 4mins tell what cell to represent, we'll reuse the cell from storyboard
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "propertyCell", for: indexPath) as! PropertyCollectionViewCell //RE ep.32 5mins since this was a customed cell, we have to return as PropertyCollectionViewCell
        
        cell.generateCell(property: properties[indexPath.row]) //RE ep.32 10mins call and generateCell from our arrays of properties
        
        return cell //RE ep.32 6mins
    }
    

//MARK: CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { //RE ep.33 1min this is when user taps on a cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { //RE ep.33 3mins
        
        return CGSize(width: collectionView.bounds.size.width, height: 280) //RE ep.33 3mins
    }
    
//MARK: Load Properties
    func loadProperties(limitNumber: Int) { //RE ep.33 6mins
        Property.fetchRecentProperties(limitNumber: limitNumber) { (allProperties) in //RE ep.33 7mins fetch our recent properties
            if allProperties.count != 0 { //RE ep.33 7mins see if we actually receive something
                self.properties = allProperties as! [Property] //RE ep.33 8mins set our properties array equal to allProperties
                self.collectionView.reloadData() //RE ep.33 8mins show all our properties
            }
        }
    }
    
    
//MARK: IBActions
    @IBAction func mixerButtonTapped(_ sender: Any) { //RE ep.29 3mins
        
    }
    

}
