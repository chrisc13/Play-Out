//
//  Event.swift
//  Play Out
//
//  Created by Chris Carbajal on 8/27/20.
//  Copyright © 2020 Chris Carbajal. All rights reserved.
//

import Foundation
import Firebase

struct Event: Identifiable, Codable{
    var id: Int?
    let description : String
    let location: String
    let time: String
    let sport: String
    let peopleNeeded: Int
}
