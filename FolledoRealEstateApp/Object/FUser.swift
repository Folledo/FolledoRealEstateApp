//
//  FUser.swift
//  FolledoRealEstateApp
//
//  Created by Samuel Folledo on 10/15/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import Foundation
import Firebase //RE ep.11 1min
import FirebaseAuth //RE ep.11 1mins

class FUser { //RE ep.11 1mins
    
    let objectId: String //RE ep.11 1mins
    var pushId: String?  //RE ep.11 2mins pushId will be the id of our user from OneSignal to send push notifications
    
    let createdAt: Date //RE ep.11 2mins
    var updatedAt: Date //RE ep.11 2mins
    
    var coins: Int //RE ep.11 3mins in app currency for user to use inside the app
    var company: String //RE ep.11 3mins
    var firstName: String //RE ep.11 3mins
    var lastName: String //RE ep.11 3mins
    var fullName: String //RE ep.11 3mins
    var avatar: String //RE ep.11 3mins
    var phoneNumber: String //RE ep.11 4mins
    var additionalPhoneNumber: String //RE ep.11 4mins
    var isAgent: Bool  //RE ep.11 4mins will keep track if our user is an agent or a buyer
    var favoriteProperties: [String] //RE ep.11 5mins
    
    
    
    init(_objectId: String, _pushId:String?, _createdAt: Date, _updatedAt: Date, _firstName: String, _lastName: String, _avatar: String = "", _phoneNumber: String = "") { //RE ep.11 6mins if you dont pass in any value, our initializer will assume it to be an empty string, phoneNumber is default empty string
        objectId = _objectId //RE ep.11 10mins
        pushId = _pushId //RE ep.11 10mins
        
        createdAt = _createdAt //RE ep.11 10mins
        updatedAt = _updatedAt //RE ep.11 10mins
        
        coins = 10 //RE ep.11 10mins
        firstName = _firstName //RE ep.11 10mins
        lastName = _lastName //RE ep.11 10mins
        fullName = _firstName + " " + _lastName //RE ep.11 10mins
        avatar = _avatar //RE ep.11 10mins
        isAgent = false //RE ep.11 10mins
        company = "" //RE ep.11 10mins
        favoriteProperties = [] //RE ep.11 10mins
        
        phoneNumber = _phoneNumber //RE ep.11 10mins
        additionalPhoneNumber = "" //RE ep.11 10mins
        
    }
    
    init(_dictionary: NSDictionary) { //RE ep.11 10mins in order to save something to our Firebase, we need to convert it to an NSDictionary which is a type JSON
        
        objectId = _dictionary[kOBJECTID] as! String //RE ep.13 0min crash if user has no objectId
        pushId = _dictionary[kPUSHID] as? String //RE ep.13 1min this one can be nil
        

        if let dcoin = _dictionary[kCOINS] { //RE ep.13 2mins
            coins = dcoin as! Int //RE ep.13 2mins
        } else { coins = 0 } //RE ep.13 2mins if no coins saved, we'll assume coins is 0
        
        if let comp = _dictionary[kCOMPANY] { //RE ep.13 2mins check company name
            company = comp as! String //RE ep.13 2mins
        } else { company = "" } //RE ep.13 2mins if no company name then set it to nothing
        
        if let fname = _dictionary[kFIRSTNAME] { //RE ep.13 2mins check name
            firstName = fname as! String //RE ep.13 2mins
        } else { firstName = "" } //RE ep.13 2mins if no name then set to nothing
    
        if let lname = _dictionary[kLASTNAME] { //RE ep.13 2mins check name
            lastName = lname as! String //RE ep.13 2mins
        } else { lastName = "" } //RE ep.13 2mins if no name then set to nothing
        
        fullName = firstName + " " + lastName //RE ep.13 3mins
        
        
        if let avat = _dictionary[kAVATAR] { //RE ep.13 2mins check name
            avatar = avat as! String //RE ep.13 2mins
        } else { avatar = "" } //RE ep.13 2mins if no name then set to nothing
        
        if let agent = _dictionary[kISAGENT] { //RE ep.13 2mins check name
            isAgent = agent as! Bool //RE ep.13 2mins
        } else { isAgent = false } //RE ep.13 2mins if no name then set to nothing
        
        if let phone = _dictionary[kPHONE] { //RE ep.13 2mins check name
            phoneNumber = phone as! String //RE ep.13 2mins
        } else { phoneNumber = "" } //RE ep.13 2mins if no name then set to nothing
        
        if let addPhone = _dictionary[kADDPHONE] { //RE ep.13 2mins check name
            additionalPhoneNumber = addPhone as! String //RE ep.13 2mins
        } else { additionalPhoneNumber = "" } //RE ep.13 2mins if no name then set to nothing
        
        if let favProp = _dictionary[kFAVORIT] { //RE ep.13 2mins check name
            favoriteProperties = favProp as! [String] //RE ep.13 2mins
        } else { favoriteProperties = [] } //RE ep.13 2mins if no name then set to nothing
        
        
        if let updated = _dictionary[kUPDATEDAT] { //RE ep.13 2mins
            updatedAt = dateFormatter().date(from: updated as! String)! //RE ep.13 2mins
        } else { updatedAt = Date() } //RE ep.13 2mins same as createdAt
        
        if let created = _dictionary[kCREATEDAT] { //RE ep.11 11mins we can access the dictionary with the keys, which we can use to save or return the value.
            createdAt = dateFormatter().date(from: created as! String)! //RE ep.12 4mins this takes a string and returns a date
        } else { //RE ep.12 4mins if there is no value, dont crash our app
            createdAt = Date() //RE ep.12 5mins so we just create from current date
        }
        
    } //RE ep.13 4mins this is our initializer when we are getting this dictionary from our firebase. We just want to keep this init func which will create out FUser for us
    
    
    class func currentId() -> String { //RE ep.13 5mins class func that will return our current user id. Difference between class func and a normal func is, normal func needs to be first instantiate the class "let user = FUser() ... user.someFunc". Class func allows you to just call "FUser.someFunc"
        return Auth.auth().currentUser!.uid //RE ep.13 6mins access our Auth and get our currentUser.uid
    }
    
    class func currentUser() -> FUser? { //RE ep.13 7mins returns our current logged in user, which can be optional so our app wont crash if there is no FUser
        if Auth.auth().currentUser != nil { //RE ep.13 8mins if there is a user
            if let dictionary = UserDefaults.standard.object(forKey: kCURRENTUSER) { //RE ep.13 8mins access our user defaults. We are saving our userDefaults under current username
                return FUser.init(_dictionary: dictionary as! NSDictionary) //RE ep.13 9mins So if we have this currentUser we'll create the FUser with dictionary as an NSDictionary
            }
        }
        return nil //RE ep.13 10mins if we dont have user in our UserDefaults, then return nil
    }
    
    class func registerUserWith(email: String, password: String, firstName: String, lastName: String, completion: @escaping (_ error: Error?) -> Void) { //RE ep.14 1mins Firebase will take all these parameters and register our user on a background thread, so main thread doesnt get blocked. So once Firebase is done registering the user, we can call our callback function (completion) which will say "Im finish registering here is what I did"
        Auth.auth().createUser(withEmail: email, password: password) { (firUser, error) in
            if let error = error { //RE ep.14 3mins if there's error
                completion(error) //RE ep.14 3mins call our completion, and heres the error. if there's error then Pass error to our function
                return //RE ep.14 3mins return so we dont run the rest of the code
            }
            
            guard let currentUserUid = firUser?.user.uid else { return } //RE ep.14 4
            let fUser = FUser(_objectId: currentUserUid, _pushId: "", _createdAt: Date(), _updatedAt: Date(), _firstName: firstName, _lastName: lastName) //RE ep.14 5mins now we have our FUser object, and now we want to save our FUser to our UserDefaults which is what we're checking in our currentUser method
            
            //save FUser to UserDefaults so we have it on our device
            saveUserLocally(fUser: fUser) //RE ep.15 10mins
            //save FUser to Firebase Database so we can access the user with all the information
            saveUserInBackground(fUser: fUser) //RE ep.15 14mins
            
            completion(error) //RE ep.14 9mins
        }
        
    }
    
} //end of class

//MARK: Saving user
func saveUserInBackground(fUser: FUser) { //RE ep.15 10mins
    let ref = firDatabase.child(kUSER).child(fUser.objectId) //RE ep.15 13mins, kUSER = "User". objectId is the user UID
    ref.setValue(userDictionaryFrom(user: fUser)) //RE ep.15 14mins Database's "User" will have the user's uid as its child, and then set the values of the userDictionary to the child uid/objectId //Overall, creates a reference for our user in our Database
}

//save locally
func saveUserLocally(fUser: FUser) { //RE ep.15 9mins
    UserDefaults.standard.set(userDictionaryFrom(user: fUser), forKey: kCURRENTUSER) //RE ep.15 9mins this method takes the user converted to an NSDictionary and puts forKey: kCURRENTUSER
    UserDefaults.standard.synchronize() //RE ep.15 10mins so it will save our objects to our UserDefaults in background on the device
}


//MARK: Helper fuctions
func userDictionaryFrom(user: FUser) -> NSDictionary { //RE ep.15 1min take a user and return an NSDictionary
    
    let createdAt = dateFormatter().string(from: user.createdAt) //RE ep.15 2mins
    let updatedAt = dateFormatter().string(from: user.updatedAt) //RE ep.15 2mins
    
    return NSDictionary(
                        objects: [user.objectId, createdAt, updatedAt, user.company, user.pushId!, user.firstName, user.lastName, user.fullName, user.avatar, user.phoneNumber, user.additionalPhoneNumber, user.isAgent, user.coins, user.favoriteProperties],
                        forKeys: [kOBJECTID as NSCopying, kCREATEDAT as NSCopying, kUPDATEDAT as NSCopying, kCOMPANY as NSCopying, kPUSHID as NSCopying, kFIRSTNAME as NSCopying, kLASTNAME as NSCopying, kFULLNAME as NSCopying, kAVATAR as NSCopying, kPHONE as NSCopying, kADDPHONE as NSCopying, kISAGENT as NSCopying, kCOINS as NSCopying, kFAVORIT as NSCopying, ]) //RE ep.15 5mins - 7mins //now this func create and return an NSDictionary
}

