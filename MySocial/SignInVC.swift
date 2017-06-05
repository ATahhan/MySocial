//
//  ViewController.swift
//  MySocial
//
//  Created by Ammar AlTahhan on 6/4/17.
//  Copyright © 2017 Ammar AlTahhan. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fbButtonPressed(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil{
                print("Unable to authenticate with Facebook")
            } else if result?.isCancelled == true {
                print("User cancelled authentication")
            } else {
                print("Succesfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
            
        }
        
    }
    
    func firebaseAuth(_ credential: AuthCredential){
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if error != nil{
                print("Unable to authinticate with firebase")
            } else {
                print("Succesfully authenticated with firebase")
            }
        })
    }


}

