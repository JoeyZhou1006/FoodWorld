//
//  SignUpNewUserViewController.swift
//  Login_Firebase
//
//  Created by Zhou Yu on 6/09/2016.
//  Copyright © 2016 Joey Zhou. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class SignUpNewUserViewController: UIViewController
{
    
    @IBOutlet weak var newUserEmail: UITextField!
    
    @IBOutlet weak var newUserPassword: UITextField!
    
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var userID=""
    
    override func viewWillAppear(_ animated: Bool) {
        self.activityIndicator.isHidden = true
    }
    
    
    @IBAction func createNewAccount(_ sender: UIButton) {
        
        //test the email address or password whether conform to the firebase authentication standards locally before uploading to firebase to check
        if(newUserEmail.text == nil || newUserPassword.text?.characters.count < 6){
            //Create the alert
            let alert = UIAlertController(title: "Ooppos", message: "password has to be at least 6 characters", preferredStyle: UIAlertControllerStyle.alert)
            
            //create an action (button)
            let okAction = UIAlertAction(title:"OK", style: .default, handler:  { action in
                
                
                //when the user tapped the ok button, navigate the user to the business profile page to set up their account
                print("ok is tapped")
                self.newUserPassword.text = ""
                self.confirmPassword.text=""
                
                }
            )
            
            //add the action to the alert controller
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
            
            
        
        }
            
        else if (self.newUserPassword.text != self.confirmPassword.text){
            
            //Create the alert
            let alert = UIAlertController(title: "Ooppos", message: "password has to be exactly the same", preferredStyle: UIAlertControllerStyle.alert)
            
            //create an action (button)
            let okAction = UIAlertAction(title:"OK", style: .default, handler:  { action in
                
                
                //when the user tapped the ok button, navigate the user to the business profile page to set up their account
                print("ok is tapped")
                self.newUserPassword.text = ""
                self.confirmPassword.text = ""
                
                }
            )
            
            //add the action to the alert controller
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)

            
        
        
        
        }
        else{
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        FIRAuth.auth()?.createUser(withEmail: newUserEmail.text!, password: newUserPassword.text!, completion: { (user: FIRUser?, error) in
            if error != nil {
                print(error)
                
                let alert = UIAlertController(title: "Opposs", message: "Seems like some one already registered with this account", preferredStyle: UIAlertControllerStyle.alert)
                
                
                
                //create an action (button)
                let okAction = UIAlertAction(title:"OK", style: .default, handler:  { action in
                    
                    
                    //when the user tapped the ok button, navigate the user to the business profile page to set up their account
                    print("ok is tapped")
                    
                    
                    }
                )
                
                alert.addAction(okAction)
                
                //show the alert
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.present(alert, animated: true, completion: nil)
                
                
                
                
                
                self.present(alert, animated: true, completion: nil)
                return
            }
            else{
            
                //Create the alert
                let alert = UIAlertController(title: "Congratulations!!!", message: "You are successfully registered with us :D ", preferredStyle: UIAlertControllerStyle.alert)
                
                //create an action (button)
                let okAction = UIAlertAction(title:"OK", style: .default, handler:  { action in
                    
                    
                    //when the user tapped the ok button, navigate the user to the business profile page to set up their account
                    print("ok is tapped")
                    self.navigateToBusinessProfile()
                    
                    
                    }
                )
                
  
                    
                //add the action to the alert controller
                alert.addAction(okAction)
                //show the alert
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.present(alert, animated: true, completion: nil)
                
                //should pass users UID to the next view
                print(user!.uid)
                //assign the unique user identifaction id to a variable
                self.userID = user!.uid
                
                
            }
        })
        
        }
        
        
    }
    
    @IBAction func dismissSignUp(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {})
    }
    
    
    //prepare the user's uid to be sent to the next view which is the business initial profile view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let businessViewController = segue.destination as! BusinessInitialProfileViewController
        
        //debug code to check whether the users uid is generated properly
        if(userID == ""){
            print("the user id is nil")
        
        }
        
        businessViewController.Uid = userID

    
        
    }
    
    
    //the function that does the action that navigate to the yours profile page
    func navigateToBusinessProfile(){
        self.performSegue(withIdentifier: "businessInitialProfileSegue", sender: self)
    
    }
    
    
    
    

    

}
