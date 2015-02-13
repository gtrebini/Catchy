//
//  NotiziaSpecificaNextVC.swift
//  Catchy
//
//  Created by TSC Consulting on 12/02/15.
//  Copyright (c) 2015 TSC Consulting. All rights reserved.
//

import UIKit

class NotiziaSpecificanextVC: UIViewController, UISearchBarDelegate, SideBarDelegate {
    
    var tuttelenotizie:Array<Notizie>!
    var notizieAll:Array<Notizie>!
    var idNotizie:Array<Int>!
    var indexCorrente:Int!
     var notiziaCorrente:Notizie!
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
        
        if segue.identifier == "showTutteleNotizieBack" {
            
            let detailVC:NotiziaSpecificaVC = segue.destinationViewController as NotiziaSpecificaVC
          detailVC.notizia = notiziaCorrente as Notizie
            detailVC.tuttelenotizie = tuttelenotizie
            
            //presentViewController(vc, animated: true, completion:nil )

            
            
        }
        
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
    @IBOutlet weak var viewSwipe: UIView!
    
    @IBAction func btnSubmit(sender: AnyObject) {
        
        sideBar.showSideBar(!sideBar.isSideBarOpen)
    }
    
    
    func sideBarDidSelectButtonAtIndex(index: Int){
        if index == 0{
            self.performSegueWithIdentifier("showFollowedStoriesVC", sender:self)
            
        }
        
    }
    
    
    
    var notizia = Notizie (pageid: 0, pageidstoria: 0, pageurl: "", pageurlstoria: "", aggiornato: NSDate(),category: "", date: NSDate(), title: "", image: UIImage(), body: "")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        searchBar2.delegate = self
        notizieAll = Array<Notizie>()
        idNotizie = Array<Int>()
        
        
        sideBar = SideBar(sourceView: self.view)
        sideBar.delegate = self
        
        
        
        dateFormatter.dateFormat = "MMM. dd yyyy / HH:mm"
        
        image2.image = notizia.image
        image2.clipsToBounds=true
        
        source2Label.text = notizia.category
        source2Label.font = UIFont (name: "Oswald-Regular", size: 16)
        
        date2Label.text = dateFormatter.stringFromDate(notizia.date).uppercaseString
        date2Label.font = UIFont (name: "Oswald-Regular", size: 16)
        
        titolo2Label.text = notizia.title.uppercaseString
        titolo2Label.font = UIFont (name: "Oswald-Regular", size: 18)
        
        body2.text = notizia.body
        
        followStory2.font = UIFont (name: "PlayfairDisplay-Italic", size: 16)
        
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        
        self.viewSwipe.addGestureRecognizer(swipeRight)
        
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.viewSwipe.addGestureRecognizer(swipeLeft)
        
        do{
            //var actInd:UIActivityIndicatorView = UIActivityIndicatorView()
            // println("notizieAll è vuota")
        }while(tuttelenotizie == nil)
        
        for x in tuttelenotizie{
            idNotizie.append(x.pageid)
        }

        indexCorrente = idNotizie.indexOf(notizia.pageid)
        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
             
               // println("Swiped right")
                do{
                    //var actInd:UIActivityIndicatorView = UIActivityIndicatorView()
                                      // println("notizieAll è vuota")
                }while(tuttelenotizie == nil)
                
                
                
                
               
                
                
                
                if  indexCorrente!-1 >= 0 && tuttelenotizie[indexCorrente!-1] !== nil {
                    var vc:NotiziaSpecificaVC = NotiziaSpecificaVC()
                    notiziaCorrente = tuttelenotizie[indexCorrente!-1]
                    performSegueWithIdentifier("showTutteleNotizieBack", sender: self)
                    println(tuttelenotizie[indexCorrente!-1].title)
                    
                }
                else {
                    println("Non ci sono notizie successive")
                }


                
                
            case UISwipeGestureRecognizerDirection.Left:
                
                do{
                  //  println("notizieAll è vuota")
                }while(tuttelenotizie == nil)
                
                
        
                
                if indexCorrente!+1 < tuttelenotizie.count && tuttelenotizie[indexCorrente!+1] !== nil{
                    var vc:NotiziaSpecificaVC = NotiziaSpecificaVC()
                    notiziaCorrente = tuttelenotizie[indexCorrente!+1]
               
                    performSegueWithIdentifier("showTutteleNotizieBack", sender: self)
                    println(tuttelenotizie[indexCorrente!+1].title)
                }else{
                    println("Non ci sono notizie precedenti")
                }

                
            default: break
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}