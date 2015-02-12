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
            
            var topolino: Int = notiziaDict["pageid-storia"] as Int
            var pippo: Int = notiziaDict["pageid"] as Int
            var minnie: String = notiziaDict["pageurl"] as String
            var pluto: String = notiziaDict["pageurl-storia"] as String
            
            
            var encodedString = notiziaDict["body"] as String
            
            
            let encodedData = encodedString.dataUsingEncoding(NSUTF8StringEncoding)!
            let attributedOptions = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType]
            
            
            let attributedString = NSAttributedString(data: encodedData, options: nil, documentAttributes: nil, error: nil)
            
            var decodedString = attributedString?.string
            
            
            
            var n = Notizie (pageid: pippo, pageidstoria: topolino, pageurl: minnie, pageurlstoria: pluto, aggiornato: dateFormatter.dateFromString(notiziaDict["aggiornato"] as String) as NSDate!, category: notiziaDict["categoria"] as String, date: dateFormatter.dateFromString(notiziaDict["data"] as String) as NSDate! , title: notiziaDict["title"] as String, image: UIImage(data: data!)!, body: decodedString! as String)
            
            
            
            
            notizie += [n]
        }
        
        notizie.sort({ $0.date.compare($1.date) == NSComparisonResult.OrderedDescending })
        
        
        return notizie
        
    }
}