//
//  ShopSetUpViewController.swift
//  Login_Firebase
//
//  Created by JoeyZhou on 26/12/16.
//  Copyright © 2016 Joey Zhou. All rights reserved.
//

import UIKit

class ShopSetUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var uid: String?
    
   
    var edit = false
    
    
    let imagePicker = UIImagePickerController()
    
    var imageTap = UITapGestureRecognizer()
    
    
   // var imageTap = UITapGestureRecognizer(target: self, action: #selector(self.ChooseImage()))
    
    @IBOutlet weak var shopDescription: UITextView!
    
    @IBOutlet weak var shopImage: UIImageView!
    
    
    @IBOutlet weak var fromTime: UIDatePicker!
    
    @IBOutlet weak var tillTime: UIDatePicker!
    
    @IBOutlet weak var minimumDeliver: UITextField!
    
    @IBOutlet weak var deliverFee: UITextField!


    
    @IBOutlet weak var editBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Configure your Shop"
        
        self.disableAllField()
       

        self.setUpFontColor()
        
        //allow gesture to work
        shopImage.isUserInteractionEnabled = true
        
        shopImage.image = #imageLiteral(resourceName: "selectImage")
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
        //create tap gesture to call function to present image picker view when user tap the image
        imageTap = UITapGestureRecognizer(target: self, action: #selector(self.ChooseImage))
       // shopImage.addGestureRecognizer(imageTap)
        
        
        print("user uid is \(self.uid)")
    
    }
    
    
    //disable all field, so user can't change anything unless they click edit button
    func disableAllField(){
        shopImage.removeGestureRecognizer(imageTap)
        shopImage.isUserInteractionEnabled = false
        shopDescription.isUserInteractionEnabled = false
        fromTime.isUserInteractionEnabled = false
        tillTime.isUserInteractionEnabled = false
        minimumDeliver.isUserInteractionEnabled = false
        deliverFee.isUserInteractionEnabled = false
       
  
    }
    
    
    //enable all field to be editable
    func enableAllField(){
        shopImage.addGestureRecognizer(imageTap)
        shopImage.isUserInteractionEnabled = true
        shopDescription.isUserInteractionEnabled = true
        fromTime.isUserInteractionEnabled = true
        tillTime.isUserInteractionEnabled = true
        minimumDeliver.isUserInteractionEnabled = true
        deliverFee.isUserInteractionEnabled = true
        //submitToFirebase.isUserInteractionEnabled = true
    
    }
    
    
    @IBAction func enableUserToEdit(_ sender: Any) {
        
        if(edit == true){
            
        edit = false
        editBtn.title = "Save"
        enableAllField()
      
        }
        else{
            edit = true
            editBtn.title = "Edit"
            disableAllField()
            //when user finished editing, they are allow to submit their changes
          
        }
        
    }
    
  
    //reaction function when user tap the imageview
    func ChooseImage(gesture: UIPanGestureRecognizer){
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
  
    }
    
    
    func setUpFontColor(){
        
        shopDescription.layer.borderColor = UIColor.black.cgColor
        shopDescription.layer.borderWidth = 1.0

    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            shopImage.contentMode = .scaleAspectFit
            shopImage.image = pickedImage
        
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
