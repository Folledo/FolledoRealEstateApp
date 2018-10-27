//
//  RegisterViewController.swift
//  FolledoRealEstateApp
//
//  Created by Samuel Folledo on 10/15/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    var phoneNumber: String? //RE ep.20 2mins
    
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
    @IBAction func requestButtonTapped(_ sender: Any) { //RE ep.10 //requestCode
        
        if phoneNumberTextField.text != "" { //RE ep.20 0min
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumberTextField.text!, uiDelegate: nil) { (verificationID, error) in //RE ep.20 1min
                
                if let error = error { //RE ep.20 1min
                    Service.presentAlert(on: self, title: "Phone Error", message: error.localizedDescription) //RE ep.20 2mins
                    return
                }
                
                //if no error verifying phoneNumber inputted, first show code textfield
                self.phoneNumber = self.phoneNumberTextField.text! //RE ep.20 3mins
                self.phoneNumberTextField.text = "" //RE ep.20 3mins remove text
                self.phoneNumberTextField.placeholder = self.phoneNumber! //RE ep.20 3mins
                self.phoneNumberTextField.isEnabled = false //RE ep.20 4mins because we dont want the user to play with the phone number textfield anymore, that is why we put it as placeholder
                self.codeTextField.isHidden = false //RE ep.20 4mins show code tf
                self.requestButton.setTitle("Register", for: .normal) //RE ep.20 5mins
                
                UserDefaults.standard.set(verificationID, forKey: kVERIFICATIONCODE) //RE ep.20 5mins set our verificationID we got from verifyPhoneNumber's completion handler to our kVERIFICATIONCODE
                UserDefaults.standard.synchronize() //RE ep.20 5mins save it
            }
        }//end of phoneNumber Textfield
        
        if codeTextField.text != "" { //RE ep.20 5mins
            FUser.registerUserWith(phoneNumber: self.phoneNumber!, verificationCode: codeTextField.text!) { (error, shouldLogin) in //RE ep.20 6mins
             //RE ep.20 7mins//check if we are login or registering
                if let error = error {
                    Service.presentAlert(on: self, title: "Phone Number Registering Error", message: error.localizedDescription)
                } //RE ep.20 7mins
                
                if shouldLogin { //RE ep.20 8mins go to main view
                    print("Go to Main View")
                    Service.toHomeTabController(on: self)
                    
                } else { //RE ep.20 8mins go to finish register view
                    print("Go to Finish Registering View")
                    Service.toHomeTabController(on: self)
                    
                }
            }
        }
    }
    
    
    @IBAction func emailRegisterButtonTapped(_ sender: Any) { //RE ep.10
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return } //RE ep.16 1min
        guard let firstName = firstNameTextField.text else { return } //RE ep.16 1min
        guard let lastName = lastNameTextField.text else { return } //RE ep.16 1min
        guard let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return } //RE ep.16 1min
        
        if Service.isValidWithEmail(email: email) && Service.isValidWithName(name: firstName) && Service.isValidWithName(name: lastName) && password.count >= 6 { //checks if email, names, and password are valid. If valid then we can register our FUser
            
            //spinner
            self.view.addSubview(spinner)
            
            FUser.registerUserWith(email: email, password: password, firstName: firstName, lastName: lastName) { (error) in //RE ep.16 2mins call our FUser's registerUserWith method
                self.spinner.stopAnimating()
                if let error = error { //RE ep.16 3mins
                    Service.presentAlert(on: self, title: "Error registering user", message: error.localizedDescription)
                    return //RE ep.16 3mins
                }
                
                //if no error registering user, then present the mainView
                self.presentMainTabAndWelcome()
            }
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) { //RE ep.10
        Service.toHomeTabController(on: self) //RE ep.10 10mins
//        self.dismiss(animated: true, completion: nil)
    }
    
    func presentMainTabAndWelcome(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:MainTabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        vc.justStarted = true //to present our welcome alert
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
    
    
} //end of Controller
