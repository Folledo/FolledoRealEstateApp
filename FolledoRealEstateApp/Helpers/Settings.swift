//
//  Settings.swift
//  FolledoRealEstateApp
//
//  Created by Samuel Folledo on 10/15/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import Foundation
import UIKit


private let dateFormat = "yyyyMMddHHmmss" //RE ep.12 3mins made it private so it will remain constant and wont be changed at all outside of this file

func dateFormatter() -> DateFormatter { //RE ep.12 1min
    let dateFormatter = DateFormatter() //RE ep.12 2mins
    dateFormatter.dateFormat = dateFormat //RE ep.12 3mins
    
    return dateFormatter //RE ep.12 4mins
}

