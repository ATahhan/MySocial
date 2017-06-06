//
//  FeedVC.swift
//  MySocial
//
//  Created by Ammar AlTahhan on 6/6/17.
//  Copyright © 2017 Ammar AlTahhan. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        let result = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("\(result)")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
    

}
