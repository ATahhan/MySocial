//
//  DataService.swift
//  MySocial
//
//  Created by Ammar AlTahhan on 6/8/17.
//  Copyright © 2017 Ammar AlTahhan. All rights reserved.
//

import Foundation
import Firebase


let DB_Base = Database.database().reference()

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = DB_Base
    private var _REF_POSTS = DB_Base.child("posts")
    private var _REF_USERS = DB_Base.child("users")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: DatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String,String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
    
}
