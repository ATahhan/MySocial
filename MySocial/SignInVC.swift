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
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text{
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("User authenticated with firebase")
                    if let user = user {
                        self.saveSignIn(id: user.uid)
                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("Unable to authenticate with firebase (creation)")
                        } else {
                            print("Succesfully authenticated with firebase (creation)")
                            if let user = user {
                                self.saveSignIn(id: user.uid)
                            }
                        }
                    })
                }
            })
        }
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
                if let user = user {
                    self.saveSignIn(id: user.uid)
                }
            }
        })
    }
    
    func saveSignIn(id: String) {
        let result = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Data saved to keychain \(result)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }


}

