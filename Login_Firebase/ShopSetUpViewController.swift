//
//  ShopSetUpViewController.swift
//  Login_Firebase
//
//  Created by JoeyZhou on 26/12/16.
//  Copyright © 2016 Joey Zhou. All rights reserved.
//
struct Location {
    let latitude: Double
    let longtitude: Double
    
}






import UIKit
import CoreLocation
import Firebase
import FirebaseDatabase

class ShopSetUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate{
    
    let tapRecognizer = UITapGestureRecognizer()
    
    //link to firebase database
    let ref = FIRDatabase.database().reference(withPath: "ShopsInformation")
    
    
    
    //location manager used to get current address
    let locationManager = CLLocationManager()
    
    var location: Location?
    
    
    //to stored the user unique identifier sent from previous view controller, and we use this to send data back to firebase
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
    
    @IBOutlet weak var locateShopBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.uid = "123"
        
        
        tapRecognizer.addTarget(self, action: #selector(self.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)

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
    
    
    
    func didTapView(gesture: UIPanGestureRecognizer){
        self.view.endEditing(true)
    
    }
    
    
    
    //receive a datepicker as argument and return a string in a format like this: 2:14 pm
    func getTimeFromDatePicker(Datepicker: UIDatePicker)-> String{
        
        var dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH:mm a"
        dateFormater.amSymbol = "AM"
        dateFormater.pmSymbol = "PM"
        let date = dateFormater.string(from: self.fromTime.date)
        return date
        
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
        locateShopBtn.isUserInteractionEnabled = false
       
  
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
        locateShopBtn.isUserInteractionEnabled = true
        

    
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
          
            self.submitToFirebase()
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
    
    
    @IBAction func LocateShopByLonLat(_ sender: Any) {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
      
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updaing location " + error.localizedDescription)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var locValue: CLLocationCoordinate2D = (manager.location?.coordinate)!
        
        print("location is \(locValue.latitude) \(locValue.longitude)")
        
        self.location = Location(latitude: locValue.latitude, longtitude: locValue.longitude)
        
        self.locateShopBtn.isEnabled = false
        self.locateShopBtn.setTitle("Located", for: .disabled)
        
        print(self.location?.latitude)
        print(self.location?.longtitude)
        
        locationManager.stopUpdatingLocation()
    }
    

    
    
    func submitToFirebase(){
        
        if(self.shopImage.image != nil && self.shopDescription.text != nil && self.minimumDeliver.text != nil && deliverFee.text != nil && self.location != nil){
            
            let jpegCompressionQuality: CGFloat = 0.9
            if let base64String = UIImageJPEGRepresentation(self.shopImage.image!, jpegCompressionQuality)?.base64EncodedString() {
                // Upload base64String to your database
                //actions here to submit those information back to the server
                let shopInfo = ShopInfoSet(shopImage: base64String ,shopDescription: self.shopDescription.text , fromTime: self.getTimeFromDatePicker(Datepicker: self.fromTime), tillTime: self.getTimeFromDatePicker(Datepicker: self.tillTime) , minimumDelivery: self.minimumDeliver.text, deliveryFee: self.deliverFee.text, editByUser: self.uid)
                
                
                
                 self.ref.child("ShopInformation").setValue(shopInfo.toAnyObject())
                
            }else{
            
                print("can't convert to string from iamge")
            }
            
         
            
            
          //  let shopInfoRef = self.ref.child("ShopInformation")
           // shopInfoRef.setValue(shopInfo.toAnyObject())
            
   // self.ref.child("ShopInformation").setValue(shopInfo.toAnyObject())
        
            
        }
        else{
            print("please fill all  the information")
        
        }
    
    
    
    }
    
    


}
