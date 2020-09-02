//
//  UserInfo.swift
//  Play Out
//
//  Created by Chris Carbajal on 6/5/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import Foundation
import UIKit

struct Users : Codable{
    
    var name: String
    var city: String
    var age: Int
    var gender: String
    var sports : [String]
    var levels: [String]
    var pictureURL : String
    
    init?(data: [String: Any]) {
        
        guard let name = data["name"] as? String,
            let city = data["city"] as? String,
            let age = data["age"] as? Int,
            let gender = data["gender"] as? String,
            let sports = data["sports"] as? [String],
            let levels = data["levels"] as? [String],
            let pictureURL = data["pictureURL"] as? String else {
                return nil
        }
        
        self.name = name
        self.city = city
        self.age = age
        self.gender = gender
        self.sports = sports
        self.levels = levels
        self.pictureURL = pictureURL
        
        
    }
    
}
