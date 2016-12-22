//
//  ViewController.swift
//  Login_Firebase
//
//  Created by Zhou Yu on 6/09/2016.
//  Copyright © 2016 Joey Zhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var Uid = ""
    
    @IBOutlet weak var userUID: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        userUID.text = Uid
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

