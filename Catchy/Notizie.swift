//
//  Notizie.swift
//  Catchy
//
//  Created by TSC Consulting on 13/01/15.
//  Copyright (c) 2015 TSC Consulting. All rights reserved.
//

import Foundation
import UIKit

class Notizie {
    
    var image = UIImage()
    var category = ""
    var date = NSDate()
    var title = ""
    var body = ""
    
    init (category: String, date: NSDate, title:String, image: UIImage, body: String){
        
        self.image = image
        self.category = category
        self.date = date
        self.title = title
        self.body = body
        
    }
    
}