//
//  NotiziaSpecificaVC.swift
//  Catchy
//
//  Created by TSC Consulting on 14/01/15.
//  Copyright (c) 2015 TSC Consulting. All rights reserved.
//

import UIKit

class NotiziaSpecificaVC: UIViewController, UISearchBarDelegate, SideBarDelegate {
    
    
    
    var dateFormatter = NSDateFormatter()
    
    var sideBar:SideBar = SideBar()
    
    
   
  
    @IBOutlet weak var searchBar2: UISearchBar!
   

    @IBAction func searchButton2(sender: AnyObject) {
        
        UIView.animateWithDuration(0.2, delay: 0.1, options: .CurveEaseOut, animations: {
            
            var frame = self.totalView.frame
            if frame.origin.y == 0{
                frame.origin.y = 40
            } else {
                frame.origin.y = 0
            }
            self.totalView.frame = frame
            }, completion: { finished in
                
        })

    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
 
        
        if (segue.identifier == "searchVC2") {
            var svc = segue.destinationViewController as SearchVC;
            svc.dataPassed = searchBar2.text
        }
     
    }
 
    
    func searchBarSearchButtonClicked( searchBar: UISearchBar!){
        
        searchBar.resignFirstResponder()
        
        
        self.performSegueWithIdentifier("searchVC2", sender:self)
        
    }

    
    
    @IBOutlet var totalView: UIView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var source2Label: UILabel!
    @IBOutlet weak var date2Label: UILabel!
    @IBOutlet weak var titolo2Label: UILabel!
    @IBOutlet weak var body2: UILabel!
    @IBOutlet weak var followStory2: UILabel!
    
    @IBAction func btnSubmit(sender: AnyObject) {
        
        sideBar.showSideBar(!sideBar.isSideBarOpen)
    }
   
    
    func sideBarDidSelectButtonAtIndex(index: Int){
        if index == 0{
            self.performSegueWithIdentifier("showFollowedStoriesVC", sender:self)

        }
        if index == 1{
            self.performSegueWithIdentifier("showCategorieVC", sender:self)
            
        }
        if index == 2{
            self.performSegueWithIdentifier("showFAQS&HELPVC", sender:self)
            
        }
        if index == 3{
            self.performSegueWithIdentifier("showOpzioniVC", sender:self)
            
        }
    }

    
     var notizia = Notizie (pageid: 0, pageidstoria: 0, pageurl: "", pageurlstoria: "", aggiornato: NSDate(),category: "", date: NSDate(), title: "", image: UIImage(), body: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar2.delegate = self
        
        
        
        sideBar = SideBar(sourceView: self.view)
        sideBar.delegate = self
       
        
        
        dateFormatter.dateFormat = "MMM. dd yyyy / HH:mm"
        
        image2.image = notizia.image
        image2.clipsToBounds=true
        
        
        
        source2Label.text = notizia.category
        source2Label.font = UIFont (name: "PlayfairDisplay-Italic", size: 16)
        
        date2Label.text = dateFormatter.stringFromDate(notizia.date).uppercaseString
        date2Label.font = UIFont (name: "Oswald-Regular", size: 16)
        
        titolo2Label.text = notizia.title.uppercaseString
        titolo2Label.font = UIFont (name: "Oswald-Regular", size: 18)
        
        body2.text = notizia.body
       
        followStory2.font = UIFont (name: "PlayfairDisplay-Italic", size: 16)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
}
