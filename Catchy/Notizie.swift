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
    var pageid: Int = 0
    var pageidstoria: Int = 0
    var pageurl = ""
    var pageurlstoria = ""
    var aggiornato = NSDate()
    
    init (pageid: Int, pageidstoria: Int, pageurl: String, pageurlstoria: String, aggiornato: NSDate, category: String, date: NSDate, title:String, image: UIImage, body: String){
        
        self.image = image
        self.category = category
        self.date = date
        self.title = title
        self.body = body
        self.pageid = pageid
        self.pageidstoria = pageidstoria
        self.pageurl = pageurl
        self.pageurlstoria = pageurlstoria
        self.aggiornato = aggiornato
        
    }

    /*
    var image: UIImage!
    var category: String!
    var date: NSDate!
    var title: String!
    var body: String
    var pageid: Int!
    var pageidstoria: Int!
    var pageurl: String!
    var pageurlstoria: String!
    var aggiornato: NSDate!
    
    init (pageid: Int, pageidstoria: Int, pageurl: String, pageurlstoria: String, aggiornato: NSDate, category: String, date: NSDate, title:String, image: UIImage, body: String){
        
        self.image = nil
        self.category = ""
        self.date = nil
        self.title = ""
        self.body = ""
        self.pageid = 0
        self.pageidstoria = 0
        self.pageurl = ""
        self.pageurlstoria = ""
        self.aggiornato = nil
        
    }

*/
}