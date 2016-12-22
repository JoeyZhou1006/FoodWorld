//
//  InvitationViewController.swift
//  Login_Firebase
//
//  Created by Zhou Yu on 12/09/2016.
//  Copyright © 2016 Joey Zhou. All rights reserved.
//

import UIKit
import FirebaseDatabase

class InvitationViewController: UIViewController {
    
    var dataRetrivingService = DataRetrievingModel.staticRetriveingModel
    
    //this function here will validate the invitation code that is being input, if succeed, then use segue to go to the sign in page
    var ref = FIRDatabase.database().reference()
    
    var refHandle: UInt!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var codeRetrived = ""
    
    @IBOutlet weak var inputCode: UITextField!
    
    
    //before the view is being displayed, make the activity indicator hidden
    override func viewWillAppear(_ animated: Bool)
    {
        //ref = FIRDatabase.database().reference()
        self.activityIndicator.isHidden = true

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    //the method that connect to the firebase database to check whether the code entered is validated or not
    @IBAction func ValidateCode(_ sender: AnyObject) {
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        

        
        self.dataRetrivingService.retriveInvitationCode(){(response) in
            self.codeRetrived = response
            self.compareRetrivedinvitationAndUserinput()
            
            
            
        }
      

    }
    
    
    
    //compare the user input invitation code and the code retrived from the firebase
    func compareRetrivedinvitationAndUserinput(){
        
        if (inputCode.text != codeRetrived) {
            
            print("validataion failed, please contact joeyzhouaus@gmail.com for enquiries")
            //create the alert
            let alert = UIAlertController(title: "Ooppos", message: "Seems like you are not invited, but don't worry, call joey at 0449978657 or sent him an email at joeyzhouaus@gmail.com for further enquiry", preferredStyle: UIAlertControllerStyle.alert)
            
            //Creat an ok action
            let okAction = UIAlertAction(title:"ok", style: .default, handler: {
                action in
                
                alert.dismiss(animated: true, completion: {})
            })
            alert.addAction(okAction)
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            
            //present the alert view that tells the user that they are not invited by the given input code
            self.present(alert, animated: true, completion: nil)
            
            
            self.inputCode.text = ""
            
            
            
        }else{
            print("congratulations, you can start to create your own business page")
            
            //create the alert
            let alert = UIAlertController(title: "Congratulations!!!", message: "Hey, welcome on board", preferredStyle: UIAlertControllerStyle.alert)
            
            //create an action
            let okAction = UIAlertAction(title:"ok", style: .default, handler: { action in
                
                //when the user tapped the ok button, navigate the user to the page sign in or sign up
                self.navigateToSignInPage()
                
                
            })
            
            //register the ok action to the alert view
            alert.addAction(okAction)
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            //show the alert view window
            self.present(alert, animated: true, completion: nil)
            
        }
    
    
    }
    
    

    
    
    @IBAction func backToMenu(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {})
        
        
    }
    
    
    func navigateToSignInPage(){
        self.performSegue(withIdentifier: "codeValidated", sender: self)
    
    
    }

}
