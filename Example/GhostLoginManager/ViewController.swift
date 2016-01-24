//
//  ViewController.swift
//  GhostLoginManager
//
//  Created by Kerr Marin Miller on 12/18/2015.
//  Copyright (c) 2015 Kerr Marin Miller. All rights reserved.
//

import UIKit
import GhostLoginManager

class ViewController: UIViewController {

    @IBOutlet var loginButton : UIButton?
    @IBOutlet var emailTextField : UITextField?
    @IBOutlet var passwordTextField : UITextField?
    @IBOutlet var domainTextField : UITextField?
    @IBOutlet var resultsTextView : UITextView?
    
    var client : GhostLoginClient?
    
    @IBAction func didTapLoginButton(sender: UIButton) {
        self.view.endEditing(true)
        
        let email = self.emailTextField!.text!
        let password = self.passwordTextField!.text!
        let domain = self.domainTextField!.text!
        
        let log = "Logging in with email: \(email) \nPassword: ****** (\(password.characters.count)) characters)\nDomain: \(domain)"
        
        let url = NSURL(string: domain)!
        let manager = GhostLoginJSONSessionManager(domainURL: url)
        let parser = GhostLoginTokenJSONParser()
        
        self.client = GhostLoginClient(manager: manager, parser: parser)
        
        self.client!.loginWithUsername(email, password: password) { (token, error) -> Void in
            guard error == nil else {
                self.resultsTextView!.text = log + "\nError: \(error!.localizedDescription)"
                return
            }
            
            self.resultsTextView!.text = log + "\nLOGGED IN!"
        }
    }
}

