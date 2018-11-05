//
//  MainTabBarController.swift
//  FolledoRealEstateApp
//
//  Created by Samuel Folledo on 10/21/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController {

    var justStarted = false //for presenting welcome alert
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //hasCurrentUser()
        
        if justStarted == true {
            presentWelcomeAlert()
        }
    }
    
    
    
    func hasCurrentUser() {
        if FUser.currentUser() == nil {
            Service.toRegisterController(on: self)
        }
    }
    
    func presentWelcomeAlert() {
        justStarted = false
        let user = FUser.currentUser()
        var greetings:String = "Welcome to Folledo's Real Estate"
        if let name = user?.firstName, name != "" { //"" is a value not a nil
            greetings = "Hi \(name)"
        }
        
        let alert = UIAlertController(title: greetings, message: "Would you like to add a new property?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel) { (action) in //RE ep.43 4mins .cancel style is bolded
            return
        }
        let updateAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            Service.toAddPropertyTab(on: self)
        }
        alert.addAction(cancelAction)
        alert.addAction(updateAction)
        self.present(alert, animated: true, completion: nil)
    }

}
