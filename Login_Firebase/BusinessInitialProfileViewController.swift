//
//  BusinessInitialProfileViewController.swift
//  Login_Firebase
//
//  Created by Zhou Yu on 8/09/2016.
//  Copyright © 2016 Joey Zhou. All rights reserved.
//

import UIKit
import Firebase

class BusinessInitialProfileViewController: UIViewController {
    
    //create firebase storage reference
    let StorageRef = FIRDatabase.database().reference()
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //here should have a reference uid of the user
    var Uid = ""
    
    override func viewWillAppear(_ animated: Bool) {
        print("signed up users uid is "+self.Uid)
        self.activityIndicator.isHidden = true
    }
    
    
    
      var exists = false
    
  
    
    @IBOutlet weak var inputName: UITextField!
    
    
    

  
    @IBAction func submitBusinessName(_ sender: AnyObject) {
        
        //check whether someone already registered with this names
        
        
        //checkWhetherBusinessNameExists()
        //sent the current users name associated with the uid to the firebase storage
        
        //1. create a reference to the storage of the firebase

        //workng code
        //save the business names associated to the business users uid under the business users database

        self.exists = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
       self.checkWhetherBusinessNameExists()
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 4)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
            if(self.exists == false){
                //self.StorageRef.child("Users").child("businessUsers").child(self.Uid).child("Business_Names").setValue(self.inputName.text)
                //add business user in a json format data,(Users/businessUsers/foodArena/addedByUser)
            self.StorageRef.child("Users").child("businessUsers").child(self.inputName.text!).child("addedByUser").setValue(self.Uid)
                print("the name is not exists")
                //Create the alert
                let alert = UIAlertController(title: "Congratulations!!!", message: "The name is not occupied", preferredStyle: UIAlertControllerStyle.alert)
                
                //create an action (button)
                let okAction = UIAlertAction(title:"OK", style: .default, handler:  { action in
                    
                    
                    //when the user tapped the ok button, navigate the user to the business profile page to set up their account
                    print("ok is tapped")
                    self.navigateToBusinessHomePage()
                    
                    }
                )
                
                //add the action to the alert controller
                alert.addAction(okAction)
                
                
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden  = true
                //present the alert
                self.present(alert, animated: true, completion: nil)
                

                
                
                
                
            }
            else{
                print("the name is already existsssss")
                //Create the alert
                let alert = UIAlertController(title: "Oppposs", message: "The name is already taken", preferredStyle: UIAlertControllerStyle.alert)
                
                //create an action (button)
                let okAction = UIAlertAction(title:"OK", style: .default, handler:  { action in
                    
                    
                    //when the user tapped the ok button, navigate the user to the business profile page to set up their account
                    print("ok is tapped")
                    self.inputName.text = ""
                    
                    }
                )
                
                //add the action to the alert controller
                alert.addAction(okAction)
                
                
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden  = true
                self.present(alert, animated: true, completion: nil)
                

            }

        })
        
        
        
        
        

            
        
}
    
    
    
    //this function should search through all the business users, and check the child attribute "name" whether exsits or not
    @IBAction func dismissCurrentView(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {})
    }
    
    
    func checkWhetherBusinessNameExists(){
        
        
        StorageRef.child("Users").child("businessUsers").observeSingleEvent(of: FIRDataEventType.value, with: {(snapshot) in
            
            if(snapshot.hasChild(self.inputName.text!)){
                self.exists = true
                print("the name is already been taken")
            }
            else{
                print("the name is not occupied")
            
            }
           
            
        })
    }
    
    
    func navigateToBusinessHomePage(){
        self.performSegue(withIdentifier: "BusinessHomePage", sender: self)
    
    }

    
    
    

}
