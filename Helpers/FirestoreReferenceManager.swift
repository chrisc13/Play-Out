//
//  FirestoreReferenceManager.swift
//  Play Out
//
//  Created by Chris Carbajal on 7/9/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import Firebase

struct FirestoreReferenceManager {
    static let users = "users"
    
    static let db = Firestore.firestore()
    static let root = db.collection(users)
    
    
}
