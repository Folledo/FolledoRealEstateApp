//
//  AddPropertyViewController.swift
//  FolledoRealEstateApp
//
//  Created by Samuel Folledo on 10/19/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class AddPropertyViewController: UIViewController { //RE ep.36 11mins
    
    var user: FUser? //RE ep.39 4mins
    
    
    @IBOutlet weak var scrollView: UIScrollView! //RE ep.38 1min
    @IBOutlet weak var topView: UIView! //RE ep.37 1min
    
    
    @IBOutlet weak var referenceCodeTextField: UITextField! //RE ep.38
    @IBOutlet weak var titleTextField: UITextField! //RE ep.38
    @IBOutlet weak var roomsTextField: UITextField! //RE ep.38
    @IBOutlet weak var bathroomsTextField: UITextField! //RE ep.38
    @IBOutlet weak var propertySizeTextField: UITextField! //RE ep.38
    @IBOutlet weak var balconySizeTextField: UITextField! //RE ep.38
    @IBOutlet weak var parkingTextField: UITextField! //RE ep.38
    @IBOutlet weak var floorTextField: UITextField! //RE ep.38
    @IBOutlet weak var addressTextField: UITextField! //RE ep.38
    @IBOutlet weak var cityTextField: UITextField! //RE ep.38
    @IBOutlet weak var countryTextField: UITextField! //RE ep.38
    @IBOutlet weak var propertyTypeTextField: UITextField! //RE ep.38
    @IBOutlet weak var advertismentTypeTextField: UITextField! //RE ep.38
    @IBOutlet weak var availableFromTextField: UITextField! //RE ep.38
    @IBOutlet weak var buildYearTextField: UITextField! //RE ep.38
    @IBOutlet weak var priceTextField: UITextField! //RE ep.38
    @IBOutlet weak var desciptionTextView: UITextView! //RE ep.38
    
    @IBOutlet weak var titleDeedSwitch: UISwitch! //RE ep.38
    @IBOutlet weak var centralHeatingSwitch: UISwitch! //RE ep.38
    @IBOutlet weak var solarWaterHeatingSwitch: UISwitch! //RE ep.38
    @IBOutlet weak var storeRoomSwitch: UISwitch! //RE ep.38
    @IBOutlet weak var airconditionerSwitch: UISwitch! //RE ep.38
    @IBOutlet weak var furnishedSwitch: UISwitch! //RE ep.38
    
    var titleDeedSwitchValue = false //RE ep.39 value of the switches
    var centralHeatingSwitchValue = false //RE ep.39
    var solarWaterHeatingSwitchValue = false //RE ep.39
    var storeRoomSwitchValue = false //RE ep.39
    var airconditionerSwitchValue = false //RE ep.39
    var furnishedSwitchValue = false //RE ep.39
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: topView.frame.size.height) //RE ep.37 2mins set scrollView's size to the screen's width and entire topView's height
  
        
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//        self.scrollView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(false)
    }
    
    
    
    func save() { //RE ep.39 6mins
        //check first before we
        if titleTextField.text != "" && referenceCodeTextField.text != "" && advertismentTypeTextField.text != "" && propertyTypeTextField.text != "" && priceTextField.text != "" { //RE ep.39 7mins if theyre empty dont continue
        //create a new property
            let newProperty = Property() //RE ep.40 0mins create a new Property with info we have
            newProperty.referenceCode = referenceCodeTextField.text! //RE ep.40 1mins
            newProperty.ownerId = user!.objectId //RE ep.40 1min
            newProperty.title = titleTextField.text! //RE ep.40 2mins
            newProperty.advertisementType = advertismentTypeTextField.text! //RE ep.40 2mins
            newProperty.price = Int(priceTextField.text!)! //RE ep.40 3mins
            
            
            if balconySizeTextField.text != "" { //RE ep.40 3mins
                newProperty.balconySize = Double(balconySizeTextField.text!)! //RE ep.40 4mins
            }
            if bathroomsTextField.text != "" { //RE ep.40 4mins
                newProperty.numberOfBathrooms = Int(bathroomsTextField.text!)! //RE ep.40 4mins
            }
            
            if buildYearTextField.text != "" { //RE ep.40 3mins
                newProperty.buildYear = buildYearTextField.text! //RE ep.40 4mins
            }
            if parkingTextField.text != "" { //RE ep.40 4mins
                newProperty.parking = Int(parkingTextField.text!)! //RE ep.40 4mins
            }
            
            if roomsTextField.text != "" { //RE ep.40 3mins
                newProperty.numberOfRooms = Int(roomsTextField.text!)! //RE ep.40 4mins
            }
            if propertySizeTextField.text != "" { //RE ep.40 4mins
                newProperty.size = Double(propertySizeTextField.text!)! //RE ep.40 4mins
            }
            
            if addressTextField.text != "" { //RE ep.40 3mins
                newProperty.address = addressTextField.text! //RE ep.40 4mins
            }
            if cityTextField.text != "" { //RE ep.40 4mins
                newProperty.city = cityTextField.text! //RE ep.40 4mins
            }
            
            if countryTextField.text != "" { //RE ep.40 3mins
                newProperty.country = countryTextField.text! //RE ep.40 4mins
            }
            if availableFromTextField.text != "" { //RE ep.40 4mins
                newProperty.availableFrom = availableFromTextField.text! //RE ep.40 4mins
            }
            
            if floorTextField.text != "" { //RE ep.40 3mins
                newProperty.floor = Int(floorTextField.text!)! //RE ep.40 4mins
            }
            if desciptionTextView.text != "" && desciptionTextView.text != "Description" { //RE ep.40 4mins
                newProperty.propertyDescription = desciptionTextView.text! //RE ep.40 4mins
            }
            
        //switches
            newProperty.titleDeeds = titleDeedSwitchValue //RE ep.40 7mins
            newProperty.centralHeating = centralHeatingSwitchValue //RE ep.40 7mins
            newProperty.solarWaterHeating = solarWaterHeatingSwitchValue //RE ep.40 8mins
            newProperty.airconditioner = airconditionerSwitchValue //RE ep.40 8mins
            newProperty.storeRoom = storeRoomSwitchValue //RE ep.40 8mins
            newProperty.isFurnished = furnishedSwitchValue //RE ep.40 8mins
            
        //property images
            newProperty.saveProperty() //RE ep.40 9mins save it
            
            Service.presentAlert(on: self, title: "Saved successfully", message: " ")
            
        } else { //RE ep.39 8mins some *** textField is empty
            ProgressHUD.showError("Error Missing required fields") //RE ep.39 8mins
        }
    }
    
    
    
//MARK: IBActions
    
    @IBAction func cameraButtonTapped(_ sender: Any) { //RE ep.38
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) { //RE ep.38
        user = FUser.currentUser()! //RE ep.39 4mins
        if !user!.isAgent { //RE ep.39 5mins if user is not agent
            //check if user can post
            save()
        } else { //RE ep.39 5mins user is an agent and save
            save()
        }
    }
    
    
    @IBAction func mapPinButtonTapped(_ sender: Any) { //RE ep.38
        
    }
    
    
    @IBAction func currentLocationButtonTapped(_ sender: Any) { //RE ep.38
        
    }
    
//switches
    @IBAction func titleDeedSwitch(_ sender: Any) { //RE ep.38
        titleDeedSwitchValue = !titleDeedSwitchValue //RE ep.39 2mins whatever it is, flip the value
    }
    @IBAction func centralHeatingSwitch(_ sender: Any) { //RE ep.38
        centralHeatingSwitchValue = !centralHeatingSwitchValue //RE ep.39 2mins
    }
    @IBAction func solarWaterSwitch(_ sender: Any) { //RE ep.38
        solarWaterHeatingSwitchValue = !solarWaterHeatingSwitchValue
    }
    
    @IBAction func storeRoomSwitch(_ sender: Any) { //RE ep.38
        storeRoomSwitchValue = !storeRoomSwitchValue //RE ep.39 2mins
    }
    @IBAction func airConditionerSwitch(_ sender: Any) { //RE ep.38
        airconditionerSwitchValue = !airconditionerSwitchValue //RE ep.39 3mins
    }
    @IBAction func furnishedSwitch(_ sender: Any) { //RE ep.38
        furnishedSwitchValue = !furnishedSwitchValue //RE ep.39 3mins
    }
    
    
}
