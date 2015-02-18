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
            var immagini:[UIImage] = [UIImage]()
            
            for i in 0...arrayImage.count-1 {
                let url = NSURL(string: arrayImage[i] as String )
                let data = NSData(contentsOfURL: url!)
                immagini.append(UIImage(data: data!)!)
            }
            
            var topolino: Int = notiziaDict["pageid-storia"] as Int
            var pippo: Int = notiziaDict["pageid"] as Int
            var minnie: String = notiziaDict["pageurl"] as String
            var pluto: String = notiziaDict["pageurl-storia"] as String
            
            
            var encodedString = notiziaDict["body"] as String
            let encodedData = encodedString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            var decodedString = NSString(data: encodedData!, encoding: NSUTF8StringEncoding)
            
            var encodeTitle = notiziaDict["title"] as String
            let encodedDataTitle = encodeTitle.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            var decodeTitle = NSString(data: encodedDataTitle!, encoding: NSUTF8StringEncoding)
            var newTitle = decodeTitle?.stringByReplacingOccurrencesOfString("&#039;", withString: "'")
            
            
            var n = Notizie (pageid: pippo, pageidstoria: topolino, pageurl: minnie, pageurlstoria: pluto, aggiornato: dateFormatter.dateFromString(notiziaDict["aggiornato"] as String) as NSDate!, category: notiziaDict["categoria"] as String, date: dateFormatter.dateFromString(notiziaDict["data"] as String) as NSDate! , title: newTitle!, image: immagini, body: decodedString!)
            
            
            
            
            notizie += [n]
        }
        
        notizie.sort({ $0.date.compare($1.date) == NSComparisonResult.OrderedDescending })
        
        
        return notizie
        
    }
}