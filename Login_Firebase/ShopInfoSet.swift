//
//  ShopInfoSet.swift
//  Login_Firebase
//
//  Created by JoeyZhou on 27/12/16.
//  Copyright © 2016 Joey Zhou. All rights reserved.
//

import Foundation
import UIKit

struct  ShopInfoSet {
    var shopImage: String?
    var shopDescription: String?
    var fromTime: String?
    var tillTime: String?
    var minimumDelivery: String?
    var deliveryFee: String?
    var editByUser: String?

    func toAnyObject() -> Any {
        return [
        "shopImage": shopImage,
        "shopDescription": shopDescription,
        "fromTime": fromTime,
        "tillTime": tillTime,
        "minimumDelivery": minimumDelivery,
        "deliveryFee": deliveryFee,
        "editByUser": editByUser
        
        ]
    
    
    }
    
    
    
}
