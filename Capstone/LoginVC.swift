//
//  LoginVC.swift
//  Capstone
//
//  Created by Lane Faison on 5/30/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginVC: UIViewController, FBSDKLoginButtonDelegate {
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginButton)
        loginButton.center = view.center
        loginButton.delegate = self
        
        if let token = FBSDKAccessToken.current() {
            fetchProfile()
        }


    
    }
    
    func fetchProfile() {
        print("fetch profile")
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start { (connection, result, error) -> Void in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let fbEmail = (result as AnyObject)["email"]! as? String {
                print(fbEmail)
            }
            
            if let fbFirst = (result as AnyObject)["last_name"]! as? String {
                print(fbFirst)
            }
            
            if let fbLast = (result as AnyObject)["first_name"]! as? String {
                print(fbLast)
            }
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("completed login")
        fetchProfile()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }

    

}

