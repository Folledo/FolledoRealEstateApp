//
//  MyPropertiesViewController.swift
//  FolledoRealEstateApp
//
//  Created by Samuel Folledo on 10/30/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class MyPropertiesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PropertyCollectionViewCellDelegate { //RE ep.84 9mins 0 is created //RE ep.85 3mins 1-4 are added
    
    var properties: [Property] = [] //RE ep.85 4mins a place to hold our properties
    
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView! //RE ep.84 9mins
    
    
    
    
    
    override func viewDidLoad() { //RE ep.84 9mins
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() { //RE ep.85 4mns
        collectionView.collectionViewLayout.invalidateLayout() //RE ep.85 5mins
    }
    
    override func viewWillAppear(_ animated: Bool) { //RE ep.85 4mins
        if !isUserLoggedIn(viewController: self) { //RE ep.85 5mins
            return //RE ep.85 5mins
        } else { //RE ep.85 5mins
            loadProperties() //RE ep.85 5mins //similar to Favorites Controller
        }
    }
    
//MARK: collectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { //RE ep.85 6mins
        return properties.count //RE ep.85 6mins
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { //RE ep.85 6mins
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "propertyCell", for: indexPath) as! PropertyCollectionViewCell //RE ep.85 6mins
        
        cell.delegate = self //RE ep.85 7mins
        cell.generateCell(property: properties[indexPath.row]) //RE ep.85 7mins
        return cell //RE ep.85 7mins
    }
    
    
//MARK: CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { //RE ep.85 8mins when when user selects an item, we want to display it
        let propertyVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "propertyController") as! PropertyViewController //RE ep.85 8mins
        propertyVC.property = properties[indexPath.row] //RE ep.85 8mins
        self.present(propertyVC, animated: true, completion: nil) //RE ep.85 8mins
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { //RE ep.85 8mins
        return CGSize(width: collectionView.bounds.size.width, height: 320) //RE ep.85 8mins same as recent/favorite controllers
    }
    
    
    
//MARK: LoadProperties
    func loadProperties(){ //RE ep.86 0mins this func will pass our whereClause to our fetchFunc which will return only the properties is equal to our userId. Then refresh collection view once it's done
        let userId = FUser.currentId() //RE ep.86 0mins
        let whereClause = "ownerId = '\(userId)'" //RE ep.86 1mins whereClause, we're going to search properties where the ownerId is our current userId
        
        Property.fetchPropertiesWithClause(whereClause: whereClause) { (allProperties) in //RE ep.86 2mins
            self.properties = allProperties as! [Property] //RE ep.86 2mins
            self.collectionView.reloadData() //RE ep.86 2mins
        }
    }
    
    
    
//MARK: PropertyCollectionView CellDelegate
    func didClickMenuButton(property: Property) { //RE ep.87 1min
        let soldStatus = property.isSold ? "Mark Available" : "Mark Sold" //RE ep.87 2mins if true, put Mark Avaiable title bar
        var topAdStatus = "Promote" //RE ep.87 3mins top ad status
        var isInTop = false //RE ep.87 3mins
        
        if property.inTopUntil != nil && property.inTopUntil! > Date() { //RE ep.87 4mins check if inTopUntil has a value, then unwrap cuz now we're sure it's not nil, is greater than current Date()
            isInTop = true //RE ep.87 4mins property should be in top properties
            topAdStatus = "Already in top" //RE ep.87 5mins
        }
        
        let optionMenu = UIAlertController(title: "Property Meny", message: nil, preferredStyle: .actionSheet) //RE ep.87 5mins Action Sheet which is a alertController

        let editAction = UIAlertAction(title: "Edit Property", style: .default) { (alert) in //RE ep.87 6mins everytime user selects edit button, this code will run
            let addPropertyVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addPropertyController") as! AddPropertyViewController //RE ep.89 1mins
            
            addPropertyVC.property = property //RE ep.89 8mins pass the selected property
            
            self.present(addPropertyVC, animated: true, completion: nil) //RE ep.89 2mins
        }
        
        let makeTopAction = UIAlertAction(title: topAdStatus, style: .default) { (action) in //RE ep.87 6mins
            print("Make Top")
            
        }
        
        let soldAction = UIAlertAction(title: soldStatus, style: .default) { (action) in //RE ep.87 6mins
            property.isSold = !property.isSold  //RE ep.88 2mins reverse the boolean value
            property.saveProperty() //RE ep.88 2mins save in background
            self.loadProperties() //RE ep.88 3mins refresh
            
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in //RE ep.78 6mins
            ProgressHUD.show("Deleting...") //RE ep.88 0mins
            property.deleteProperty(property: property, completion: { (message) in //RE ep.88 1mins delete our property...
                ProgressHUD.showSuccess("Deleted!") //RE ep.88 1min
                self.loadProperties() //RE ep.88 2mins refresh collectionView
            })
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in //RE ep.87 6mins
            print("Cancel")
            optionMenu.dismiss(animated: true, completion: nil) //RE ep.88
            
        }
        
        optionMenu.addAction(editAction) //RE ep.87 8mins
        optionMenu.addAction(makeTopAction) //RE ep.87 8mins
        optionMenu.addAction(soldAction) //RE ep.87 8mins
        optionMenu.addAction(deleteAction) //RE ep.87 8mins
        optionMenu.addAction(cancelAction) //RE ep.87 9mins
        
        self.present(optionMenu, animated: true, completion: nil) //RE ep.87 8mins
    }
    
}
