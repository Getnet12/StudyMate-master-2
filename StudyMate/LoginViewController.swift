//
//  LoginViewController.swift
//  StudyMate
//
//  Created by user168675 on 6/2/20.
//  Copyright © 2020 Getnet Mekuriyaw. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, PFLogInViewControllerDelegate {
    var logInViewController: PFLogInViewController!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //present login page using Parse UI
        super.viewDidAppear(animated)
       // if (PFUser.current() != nil) {
         //   print("User is already logged in")
        //    return
       // }
        self.logInViewController = PFLogInViewController()
        self.logInViewController.fields = [PFLogInFields.usernameAndPassword,
                          PFLogInFields.logInButton,
                          PFLogInFields.signUpButton]
        self.present(self.logInViewController,  animated: true, completion:nil)
        
    }
    
    //Login to the app
    //what if there's an error??
    // Sent to the delegate to determine whether the log in request should be submitted to the server.
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username:String, password: String) -> Bool {
        if (!username.isEmpty && !password.isEmpty) {
            return true // Begin login process
        }
        
        _ = NSLocalizedString("Missing Information", comment: "")
        _ = NSLocalizedString("Make sure you fill out all of the information!", comment: "")
        _ = NSLocalizedString("OK", comment: "")
        let alert = UIAlertController(title: description, message: nil, preferredStyle: .alert)
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        return false // Interrupt login process
    }
    
     // Sent to the delegate when a PFUser is logged in.
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismiss(animated: true, completion: nil)
       
    }

    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        if let description = error?.localizedDescription {
            _ = NSLocalizedString("OK", comment: "")
            let alert = UIAlertController(title: description, message: nil, preferredStyle: .alert)
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
        }
        print("Failed to log in...")
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            } else {
                //if there was an error logging in, you need to inform the user
                // that their user name or password was incorrect
                print("Error: \(error?.localizedDescription)")            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in
            if success{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else{
                //If there is an error signing up, you need to inform the user
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
