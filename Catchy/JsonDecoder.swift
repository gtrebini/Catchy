//
//  JsonDecoder.swift
//  Catchy
//
//  Created by TSC Consulting on 26/01/15.
//  Copyright (c) 2015 TSC Consulting. All rights reserved.
//

import Foundation
import UIKit


class JsonDecoder {
    
    
    
    
    class func  decodeNews(jsonString:NSString) -> Array<Notizie> {
        
        var error: NSError?
        
        var notizie: [Notizie] = [Notizie]()
        
        
       
        
        
        var json: NSArray = NSJSONSerialization.JSONObjectWithData(jsonString.dataUsingEncoding(NSUTF8StringEncoding)!, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSArray
        
       
        
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        
        
        for notiziaDict in json {
            
            var arrayImage: Array<String> = notiziaDict["immagini"] as Array<String>
            
            let url = NSURL(string: arrayImage[0] as String )
            let data = NSData(contentsOfURL: url!)
            
            
            
            
            
            var n = Notizie (pageid: notiziaDict["pageid"] as Int, pageidstoria: notiziaDict["pageidstoria"] as Int, pageurl: notiziaDict["pageurl"] as String, pageurlstoria: notiziaDict["pageurlstoria"] as String, aggiornato: notiziaDict["aggiornato"] as NSDate!, category: notiziaDict["categoria"] as String, date: dateFormatter.dateFromString(notiziaDict["data"] as String) as NSDate! , title: notiziaDict["title"] as String, image: UIImage(data: data!)!, body: notiziaDict["body"] as String)
            
            
            
            
            notizie += [n]
        }
        
        notizie.sort({ $0.date.compare($1.date) == NSComparisonResult.OrderedDescending })
        
        
        return notizie
        
    }
}