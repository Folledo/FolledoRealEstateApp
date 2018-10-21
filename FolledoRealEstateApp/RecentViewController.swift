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
    
    var numberOfPropertiesTextField: UITextField? //RE ep.43 3mins
    
    
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { //RE ep.36 4mins tell what cell to represent, we'll reuse the cell from storyboard
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
        let alert = UIAlertController(title: "Update", message: "Set the number of properties to display", preferredStyle: .alert) //RE ep.43 0min
        alert.addTextField { (numberOfProperties) in //RE ep.43 1min
            numberOfProperties.placeholder = "Number of Properties" //RE ep.43 1min
            numberOfProperties.borderStyle = .roundedRect //RE ep.43 2mins
            numberOfProperties.keyboardType = .numberPad //RE ep.43 2mins //now we need a textfield so we can assign it to so it will be a global value
            
            self.numberOfPropertiesTextField = numberOfProperties //RE ep.43 3mins
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in //RE ep.43 4mins .cancel style is bolded
            return
        }
        let updateAction = UIAlertAction(title: "Update", style: .default) { (action) in //RE ep.43 4mins
            if self.numberOfPropertiesTextField?.text != "" && self.numberOfPropertiesTextField!.text != "0" { //RE ep.43 5mins check if our textfield has a value //RE ep.44 0min && added, Since loadProperties calls fetchRecent, if we have 0 topAd, it will not call and reload the table. So we added this extra error check to make sure user doesnt or is not allowed to put 0 results
                ProgressHUD.show("Updating...") //RE ep.43 5mins show user we're updating...
                self.loadProperties(limitNumber: Int(self.numberOfPropertiesTextField!.text!)!) //RE ep.43 6mins call this controller's method that loads properties based on the passed Int parameter
                ProgressHUD.dismiss()
            }
        }
        alert.addAction(cancelAction) //RE ep.43 7mins
        alert.addAction(updateAction) //RE ep.43 7mins
        self.present(alert, animated: true, completion: nil) //RE ep.43 7mins
    } //RE end of mixerButtonTapped
    

}
