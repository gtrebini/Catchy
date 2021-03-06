//
//  NotiziaSpecificaVC.swift
//  Catchy
//
//  Created by TSC Consulting on 14/01/15.
//  Copyright (c) 2015 TSC Consulting. All rights reserved.
//

import UIKit
import Foundation

class NotiziaSpecificaVC: UIViewController, UISearchBarDelegate, SideBarDelegate, UIScrollViewDelegate {
    
    var tuttelenotizie:Array<Notizie>!
    var notizieAll:Array<Notizie>!
    var idNotizie:Array<Int>!
    var indexCorrente:Int!
    var notiziaCorrente:Notizie!
    var dateFormatter = NSDateFormatter()
    var sideBar:SideBar = SideBar()
    let transitionManager = TransitionManager()
    var isRight:Bool!
    var actInd:UIActivityIndicatorView!
    var notiziaIndexCorrente:Notizie!
    var immaginiNotiziaCorrente:[UIImage]!
    var immaginiIndexCorrente:Int!
    var username:String!
    var password:String!
    var follow:Bool!
    var path:String!
    var fileManager:NSFileManager!
    
    @IBOutlet var followButton: UIButton!

    
    @IBOutlet weak var searchBar2: UISearchBar!
    @IBOutlet var totalView: UIView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var source2Label: UILabel!
    @IBOutlet weak var date2Label: UILabel!
    @IBOutlet weak var titolo2Label: UILabel!
    @IBOutlet weak var body2: UILabel!
    @IBOutlet weak var followStory2: UILabel!
    @IBOutlet weak var viewSwipe: UIView!
    @IBOutlet var storiaTitolo: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageBaffo: UIButton!
    @IBOutlet var followStoryLabel: UILabel!
    
    @IBOutlet var viewFollowStoryLabel: UIView!
    
    
    var notizia = Notizie (pageid: 0, pageidstoria: 0, pageurl: "", pageurlstoria: "", titlestoria: "", aggiornato: NSDate(),category: "", date: NSDate(), title: "", image: [UIImage](), body: "")
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        

        
        notizieSearch = [Notizie]()
        
        scrollView.delegate = self
        
        follow = false
        if(storieSeguite.count > 0){
            println(storieSeguite)
            for i in 0...storieSeguite.count-1{
                var stSeg:AnyObject = storieSeguite[i]
                if(notizia.pageidstoria == stSeg as? Int){
                    follow = true
                }
            }
            
        }else{
            follow = false
        }
        println(follow)
        
        if(follow==true){
            var imageButton:UIImage = UIImage(named: "followButton")!
            var sizeImageButton = CGSizeMake(90, 66)
            self.followButton.setImage(imageButton, forState: .Normal)
            
            self.followStoryLabel.text = "followed story"
            self.followStoryLabel.font = UIFont (name: "PlayfairDisplay-Italic", size: 16)
            self.followStoryLabel.textColor = UIColor(red: 217/255, green: 120/255, blue: 0, alpha: 1)
            self.followStoryLabel.backgroundColor = UIColor(red: 255/255, green: 179/255, blue: 0, alpha: 1)
            self.viewFollowStoryLabel.backgroundColor = UIColor(red: 255/255, green: 179/255, blue: 0, alpha: 1)
        }else{
            var imageButton:UIImage = UIImage(named: "unfollowed.png")!
            var sizeImageButton = CGSizeMake(90, 66)
            self.followButton.setImage(imageButton, forState: .Normal)
            
            self.followStoryLabel.text = "follow story"
            self.followStoryLabel.font = UIFont (name: "PlayfairDisplay-Italic", size: 16)
            self.followStoryLabel.textColor = UIColor.blackColor()
            self.followStoryLabel.backgroundColor = UIColor(red: 217/255, green: 214/255, blue: 215/255, alpha: 1)
            self.viewFollowStoryLabel.backgroundColor = UIColor(red: 217/255, green: 214/255, blue: 215/255, alpha: 1)
 
        }
        
        searchBar2.delegate = self
        notizieAll = Array<Notizie>()
        idNotizie = Array<Int>()
        
        
        sideBar = SideBar(sourceView: self.view)
        sideBar.delegate = self
        
        dateFormatter.dateFormat = "MMM. dd yyyy / HH:mm:ss"
        
        storiaTitolo.text = notizia.titlestoria
        storiaTitolo.font = UIFont (name: "PlayfairDisplay-Italic", size: 18)
        
        image2.image = notizia.image[0]
        image2.clipsToBounds=true
        
        source2Label.text = notizia.category
        source2Label.font = UIFont (name: "Oswald-Regular", size: 16)
        
        date2Label.text = dateFormatter.stringFromDate(notizia.date).uppercaseString
        date2Label.font = UIFont (name: "Oswald-Regular", size: 16)
        
        titolo2Label.text = notizia.title.uppercaseString
        titolo2Label.font = UIFont (name: "Oswald-Regular", size: 18)
        
        body2.text = notizia.body
        
        followStory2.font = UIFont (name: "PlayfairDisplay-Italic", size: 16)
        
        
        if tuttelenotizie == nil {
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://23.251.141.230/" + notizia.pageurlstoria)!)
            request.HTTPMethod = "POST"
            let postString = ""
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(data, response, error)
                
                in
                
                if error != nil {
                    println("error=\(error)")
                    return
                }
                
                
                
                let   responseString = NSString(data: data, encoding: NSUTF8StringEncoding)!
                self.tuttelenotizie = JsonDecoder.decodeNews(responseString)
                
            })
            
            task.resume()
            
            dispatch_async(dispatch_get_main_queue(),{
                
                
                
                
            })
            
        }
        
       
        do{
            
           
        }while(tuttelenotizie == nil)
        
        for x in tuttelenotizie{
            idNotizie.append(x.pageid)
        }
        
        indexCorrente = idNotizie.indexOf(notizia.pageid)
        
        notiziaIndexCorrente = tuttelenotizie[indexCorrente]
        immaginiNotiziaCorrente = notiziaIndexCorrente.image as [UIImage]
        immaginiIndexCorrente = 0
        
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.viewSwipe.addGestureRecognizer(swipeRight)
        
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.viewSwipe.addGestureRecognizer(swipeLeft)
        
        
        
        var swipeRightImmagini = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGestureImmagini:")
        swipeRightImmagini.direction = UISwipeGestureRecognizerDirection.Right
        println("swipeRight")
        self.image2.addGestureRecognizer(swipeRightImmagini)
        
        
        var swipeLeftImmagini = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGestureImmagini:")
        swipeLeftImmagini.direction = UISwipeGestureRecognizerDirection.Left
        println("swipeLeft")
        self.image2.addGestureRecognizer(swipeLeftImmagini)
        
        let paths=NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0] as NSString
        path=documentsDirectory.stringByAppendingPathComponent("LoginFile.plist")
        fileManager = NSFileManager.defaultManager()
        if(fileManager.fileExistsAtPath(path)){
            var fileContent:NSData = fileManager.contentsAtPath(path)!
            var str:NSString = NSString (data: fileContent, encoding: NSUTF8StringEncoding)!
             username = str.componentsSeparatedByString("_")[0] as String
             password = str.componentsSeparatedByString("_")[1] as String
            println(username)
            println(password)
        }

        var streamReader = StreamReader (path:path)
        while let line = streamReader?.nextLine(){
            println(line)
        }
        
        
    }

    @IBAction func btnBaffo(sender: AnyObject) {
        scrollView.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated: true)

    }
    
    @IBAction func btnSubmit(sender: AnyObject) {
        
        sideBar.showSideBar(!sideBar.isSideBarOpen)
        if  sideBar.isSideBarOpen == false{
            
            sideBar.sideBarContainerView.hidden = true
        }
    }
    
    
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
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            //reach bottom
            
            
            
            imageBaffo.setImage(UIImage(named:"bracket_green.pdf"),forState:UIControlState.Normal)
            
        }
        
        if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)){
            imageBaffo.setImage(UIImage(named:"bracket_gray.pdf"),forState:UIControlState.Normal)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "showTutteleNotizie" {
            
            let detailVC:NotiziaSpecificanextVC = segue.destinationViewController as NotiziaSpecificanextVC
            detailVC.notizia = notiziaCorrente as Notizie
            detailVC.tuttelenotizie = tuttelenotizie
            
            
           detailVC.view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
            if(isRight==true){
            
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.view.frame = CGRectOffset(self.view.frame, -UIScreen.mainScreen().bounds.width, 0.0)
                detailVC.view.frame = CGRectOffset(detailVC.view.frame, -UIScreen.mainScreen().bounds.width, 0.0)
            })
            }else if(isRight==false){
             UIView.animateWithDuration(0.5, animations: { () -> Void in
                
                self.view.frame = CGRectOffset(self.view.frame, UIScreen.mainScreen().bounds.width, 0.0)
                detailVC.view.frame = CGRectOffset(detailVC.view.frame, UIScreen.mainScreen().bounds.width, 0.0)
                
                })
            }
            
            
         
        }
        
        
        if (segue.identifier == "searchVC2") {
            var svc = segue.destinationViewController as SearchVC;
            svc.dataPassed = searchBar2.text
            svc.countSearch = notizieSearch.count
            
            for n in notizieSearch{
                
                svc.notizia = n
            }
        }
        
    }
    
    
    
    func searchBarSearchButtonClicked( searchBar: UISearchBar!){
        notizieSearch = [Notizie]()
        searchBar2.resignFirstResponder()
        
        do{
            
        }while(news.count==0)
        
        for n in news {
           
            if (NSString(string: n.title).localizedCaseInsensitiveContainsString(searchBar2.text) || NSString(string: n.body).localizedCaseInsensitiveContainsString(searchBar2.text)){
                println("OK")
                notizieSearch.append(n)
                
            }
           
        }
        self.performSegueWithIdentifier("searchVC2", sender:self)
        
    }
    

    
    func sideBarDidSelectButtonAtIndex(index: Int){
        if index == 0{
            sideBar.sideBarContainerView.hidden = true
            sideBar.showSideBar(false)
            self.performSegueWithIdentifier("showFollowedStoriesVC", sender:self)
            
        }
        if index == 1{
            sideBar.sideBarContainerView.hidden = true
            sideBar.showSideBar(false)
            self.performSegueWithIdentifier("showMainNewsVC", sender:self)
        }
        
        if index == 2{
            
            sideBar.sideBarContainerView.hidden = true
            sideBar.showSideBar(false)
            self.performSegueWithIdentifier("showCustomizeTopicsVC", sender:self)
        }
        
        if index == 3{
            sideBar.sideBarContainerView.hidden = true
            sideBar.showSideBar(false)
            self.performSegueWithIdentifier("showFAQS&HelpVC", sender:self)
        }
        
        if index == 4{
            sideBar.sideBarContainerView.hidden = true
            sideBar.showSideBar(false)
            self.performSegueWithIdentifier("showOptionsVC", sender:self)
        }
        
    }

    
    
    
  func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                case UISwipeGestureRecognizerDirection.Right:
                     isRight=false
                       println("isright=false")
                    do{
                        
                    }while(tuttelenotizie == nil)
                    
                    
                    if  indexCorrente!-1 >= 0 && tuttelenotizie[indexCorrente!-1] !== nil {
                        var vc:NotiziaSpecificanextVC = NotiziaSpecificanextVC()
                        notiziaCorrente = tuttelenotizie[indexCorrente!-1]
                    
                        performSegueWithIdentifier("showTutteleNotizie", sender: self)
                        
                        
                        
                    
                    }
                        else {
                            println("Non ci sono notizie successive")
                        }
                
                
                case UISwipeGestureRecognizerDirection.Left:
                    isRight=true
                    println("isright=true")
                    do{
                        
                    }while(tuttelenotizie == nil)
                
                    if indexCorrente!+1 < tuttelenotizie.count && tuttelenotizie[indexCorrente!+1] !== nil{
                        
                        var vc:NotiziaSpecificanextVC = NotiziaSpecificanextVC()
                        notiziaCorrente = tuttelenotizie[indexCorrente!+1]
                    
                        performSegueWithIdentifier("showTutteleNotizie", sender: self)
             
                        
                       
                        
                    }else{
                        println("Non ci sono notizie precedenti")
                    }

                default: break
            }
        }
    }
    
    
    func respondToSwipeGestureImmagini(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                isRight=false
                do{
                    
                }while(tuttelenotizie == nil)
                
                if  immaginiIndexCorrente!-1 >= 0  && immaginiNotiziaCorrente[immaginiIndexCorrente!-1] !== nil{
                    var imageNext:UIImage = immaginiNotiziaCorrente[immaginiIndexCorrente!-1]
                    image2.image = immaginiNotiziaCorrente[immaginiIndexCorrente!-1]
                    immaginiIndexCorrente = immaginiIndexCorrente-1
                    
                    UIView.transitionWithView(self.image2, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: { () -> Void in
                        self.image2.image = imageNext
                    }, completion: nil)
                }
                else {
                    println("Non ci sono immagini successive")
                }
                
                
            case UISwipeGestureRecognizerDirection.Left:
                isRight=true
                do{
                    
                }while(tuttelenotizie == nil)
            
                if immaginiIndexCorrente!+1 < immaginiNotiziaCorrente.count && immaginiNotiziaCorrente[immaginiIndexCorrente!+1] !== nil{
                    var imageNext:UIImage = immaginiNotiziaCorrente[immaginiIndexCorrente!+1]
                    image2.image = immaginiNotiziaCorrente[immaginiIndexCorrente!+1]
                    immaginiIndexCorrente = immaginiIndexCorrente+1
                    
                    UIView.transitionWithView(self.image2, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: { () -> Void in
                        self.image2.image = imageNext
                        }, completion: nil)
                    
                }else{
                    println("Non ci sono immagini precedenti")
                }
                
            default: break
            }
        }
    }

   
   
    @IBAction func followButtonPressed(sender: AnyObject) {
        
        if(follow == false){
            if(username != nil && password != nil){
            
                let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8888/Catchy/followedUserStories.php")!)
                request.HTTPMethod = "POST"
                var titleStoria = notizia.titlestoria
                var titleStoriaLower = titleStoria.lowercaseString
                var titleStoriaNoApostrophe = titleStoriaLower.stringByReplacingOccurrencesOfString("'", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)

                var titleStoriaNoBlank = titleStoriaNoApostrophe.stringByReplacingOccurrencesOfString(" ", withString: "-", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
                var idStoria = notizia.pageidstoria
            
                let postString = "username=\(username)&password=\(password)&titlestoria=\(titleStoriaNoBlank)&idstoria=\(idStoria)"
            
                request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
                let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(data, response, error)
                    in
                
                    if error != nil {
                        println("error=\(error)")
                        return
                    }
                
                    let   responseString = NSString(data: data, encoding: NSUTF8StringEncoding)!
                    println("response: \(responseString)")
                    
                    if(responseString.containsString("Success")){
                         dispatch_async(dispatch_get_main_queue()){
                            
                            //var notiziaString1:String = "\(self.notizia.pageid)"+"_"+"\(self.notizia.pageidstoria)"+"_"
                            //var notiziaString2:String = self.notizia.pageurlstoria+"_"+self.notizia.titlestoria+"_"
                            //var notiziaString3: String = "\(self.notizia.aggiornato)"+"_"+self.notizia.category
                            //var notiziaString4:String = "_"+"\(self.notizia.date)"+"_"+self.notizia.title
                            //var notiziaString5:String = "_"+"\(self.notizia.image)"+"_"+self.notizia.body+"\n"
                            //var notiziaString:String = notiziaString1+notiziaString2+notiziaString3+notiziaString4+notiziaString5
                            //var content:NSData = notiziaString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
                            //content.writeToFile(self.path, atomically: true)
                           
                         
                        if(!self.containsElement(storieSeguite,value: self.notizia.pageidstoria)){
                                storieSeguite.addObject(self.notizia.pageidstoria)
                        }
                            
                        var imageButton:UIImage = UIImage(named: "followButton")!
                        var sizeImageButton = CGSizeMake(90, 66)
                        self.followButton.setImage(imageButton, forState: .Normal)
                        
                        self.followStoryLabel.text = "followed story"
                        self.followStoryLabel.font = UIFont (name: "PlayfairDisplay-Italic", size: 16)
                        self.followStoryLabel.textColor = UIColor(red: 217/255, green: 120/255, blue: 0, alpha: 1)
                        self.followStoryLabel.backgroundColor = UIColor(red: 255/255, green: 179/255, blue: 0, alpha: 1)
                        self.viewFollowStoryLabel.backgroundColor = UIColor(red: 255/255, green: 179/255, blue: 0, alpha: 1)
                    }
                }
                

                })
                task.resume()
            }
        }else if(follow==true){
            if(username != nil && password != nil){
                storieSeguite.removeObject(notizia.pageidstoria)
                let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8888/Catchy/unfollowedUserStories.php")!)
                request.HTTPMethod = "POST"
                var titleStoria = notizia.titlestoria
                var titleStoriaLower = titleStoria.lowercaseString
                var titleStoriaNoApostrophe = titleStoriaLower.stringByReplacingOccurrencesOfString("'", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                
                var titleStoriaNoBlank = titleStoriaNoApostrophe.stringByReplacingOccurrencesOfString(" ", withString: "-", options: NSStringCompareOptions.LiteralSearch, range: nil)
                
                var idStoria = notizia.pageidstoria
                
                let postString = "username=\(username)&password=\(password)&titlestoria=\(titleStoriaNoBlank)&idstoria=\(idStoria)"
                
                request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
                let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(data, response, error)
                    in
                    
                    if error != nil {
                        println("error=\(error)")
                        return
                    }
                    
                    let   responseString = NSString(data: data, encoding: NSUTF8StringEncoding)!
                    println("response: \(responseString)")
                    
                    if(responseString.containsString("Success")){
                        dispatch_async(dispatch_get_main_queue()){
                          
                            
                            var imageButton:UIImage = UIImage(named: "unfollowed.png")!
                            var sizeImageButton = CGSizeMake(90, 66)
                            self.followButton.setImage(imageButton, forState: .Normal)
                            
                            self.followStoryLabel.text = "follow story"
                            self.followStoryLabel.font = UIFont (name: "PlayfairDisplay-Italic", size: 16)
                            self.followStoryLabel.textColor = UIColor.blackColor()
                            self.followStoryLabel.backgroundColor = UIColor(red: 217/255, green: 214/255, blue: 215/255, alpha: 1)
                            self.viewFollowStoryLabel.backgroundColor = UIColor(red: 217/255, green: 214/255, blue: 215/255, alpha: 1)
                        }
                    }
                    
                    
                })
                task.resume()
            }

        }
        
    }
    
    func containsElement(storieSeguiteFunc:NSMutableArray, value:Int)->Bool{
        for st in storieSeguiteFunc{
            if st as Int == value{
                return false
            }
        }
        return true
    }
    
    
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}

extension Array{
    func indexOf <T:Equatable> (x:T) -> Int? {
        for i in 0...self.count {
            if self[i] as T == x {
                return i
            }
        }
        return nil
    }
}





/*extension UIView {
    func slideRight(duration:NSTimeInterval = 1.0, completionDelegate:AnyObject? = nil){
        var slideRightTransition = CATransition()
        
        if let delegate:AnyObject = completionDelegate {
            slideRightTransition.delegate = delegate
        }
        
        slideRightTransition.type = kCATransitionFromLeft
        slideRightTransition.duration = duration
       
        
        self.layer.addAnimation(slideRightTransition, forKey: "slideRightTransition")
    }
}*/

