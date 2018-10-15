//
//  RegisterViewController.swift
//  FolledoRealEstateApp
//
//  Created by Samuel Folledo on 10/15/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //spinner
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .whiteLarge
        spinner.center = self.view.center
        spinner.startAnimating()
        return spinner
    }()
    
//phone
    @IBOutlet weak var phoneNumberTextField: UITextField! //RE ep.10
    @IBOutlet weak var codeTextField: UITextField! //RE ep.10
    @IBOutlet weak var requestButton: UIButton! //RE ep.10
    
//email
    @IBOutlet weak var emailTextField: UITextField! //RE ep.10
    @IBOutlet weak var firstNameTextField: UITextField! //RE ep.10
    @IBOutlet weak var lastNameTextField: UITextField! //RE ep.10
    @IBOutlet weak var passwordTextField: UITextField! //RE ep.10
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(false)
    }
        
    
    
    
    
//MARK: IBActions
    @IBAction func requestButtonTapped(_ sender: Any) { //RE ep.10
        
        
    }
    
    
    @IBAction func emailRegisterButtonTapped(_ sender: Any) { //RE ep.10
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return } //RE ep.16 1min
        guard let firstName = firstNameTextField.text else { return } //RE ep.16 1min
        guard let lastName = lastNameTextField.text else { return } //RE ep.16 1min
        guard let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return } //RE ep.16 1min
        
        if Service.isValidWithEmail(email: email) && Service.isValidWithName(name: firstName) && Service.isValidWithName(name: lastName) && password.count >= 6 { //checks if email, names, and password are valid
            
            //spinner
            self.view.addSubview(spinner)
            
            FUser.registerUserWith(email: email, password: password, firstName: firstName, lastName: lastName) { (error) in //RE ep.16 2mins call our FUser's registerUserWith method
                self.spinner.stopAnimating()
                if let error = error { //RE ep.16 3mins
                    Service.presentAlert(on: self, title: "Error registering user", message: error.localizedDescription)
                    return //RE ep.16 3mins
                }
                
                //if no error registering user, then present the mainView
                Service.toHomeTabController(on: self)
            }
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) { //RE ep.10
        Service.toHomeTabController(on: self) //RE ep.10 10mins
//        self.dismiss(animated: true, completion: nil)
    }
    

}
