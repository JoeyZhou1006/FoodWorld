//
//  FoodArenaViewController.swift
//  Login_Firebase
//
//  Created by Zhou Yu on 8/09/2016.
//  Copyright © 2016 Joey Zhou. All rights reserved.
//

import UIKit

class FoodArenaViewController: UITabBarController {
    var Uid = ""
    
    @IBOutlet weak var userUID: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        userUID.text = Uid
        
    }
    
    

}
