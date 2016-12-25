//
//  ShopSetUpViewController.swift
//  Login_Firebase
//
//  Created by JoeyZhou on 26/12/16.
//  Copyright © 2016 Joey Zhou. All rights reserved.
//

import UIKit

class ShopSetUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let imagePicker = UIImagePickerController()
    
    
   // var imageTap = UITapGestureRecognizer(target: self, action: #selector(self.ChooseImage()))
    
    @IBOutlet weak var shopDescription: UITextView!
    
    @IBOutlet weak var shopImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        self.setUpFontColor()
        
        //allow gesture to work
        shopImage.isUserInteractionEnabled = true
        
        shopImage.image = #imageLiteral(resourceName: "selectImage")
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
        //create tap gesture to call function to present image picker view when user tap the image
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(self.ChooseImage))
        shopImage.addGestureRecognizer(imageTap)
        
    
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
    
    
    
//    @IBAction func selectImage(_ sender: Any) {
//        imagePicker.allowsEditing = false
//        imagePicker.sourceType = .photoLibrary
//        
//        self.present(imagePicker, animated: true, completion: nil)
//        
//        
//    }
    
    
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
