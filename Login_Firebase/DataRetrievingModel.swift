//
//  DataRetrievingModel.swift
//  Login_Firebase
//
//  Created by JoeyZhou on 23/12/16.
//  Copyright © 2016 Joey Zhou. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class DataRetrievingModel{
    
    
    
    var ref = FIRDatabase.database().reference()
    public static let staticRetriveingModel = DataRetrievingModel()
    
    
    func retriveInvitationCode(completionHandler: @escaping (String) -> ()) -> (){
        
        var codeRetrieved = ""
        print("talking to the database")
        ref.child("InvitationCode").observeSingleEvent(of: .value, with: {
            (snapshot) in
            
            print("inside observesingle event method=======================")
            if(!snapshot.exists()){
                print("the snap shot doesn't exist")
                return
            }
            else{
                print("talking to the database")
                //retrieve all the data sets in the database
                let dataDict = snapshot.value as! [String: AnyObject]
                print(dataDict)
               // self.codeRetrived = dataDict["Invitation1"] as! String
                
                print("the retrieved code is",dataDict["Invitation1"])
                codeRetrieved = dataDict["Invitation1"] as! String
            }
            
            completionHandler(codeRetrieved)
            
        })
     
    }

    
    
    
    
}
