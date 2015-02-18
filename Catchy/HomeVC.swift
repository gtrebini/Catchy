//
//  HomeVC.swift
//  Catchy
//
//  Created by TSC Consulting on 12/01/15.
//  Copyright (c) 2015 TSC Consulting. All rights reserved.
//

import UIKit
import Foundation

    var news = [Notizie]()
    var notizieSearch = [Notizie]()


class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, SideBarDelegate {
    
    
    var sideBar:SideBar = SideBar()
    var actInd:UIActivityIndicatorView!

    
   
    @IBOutlet weak var todayIsAbout: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet var totalView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
  
        notizieSearch = [Notizie]()
        
        actInd = UIActivityIndicatorView()
        actInd.frame = CGRectMake(self.view.frame.width/2-50 , self.view.frame.height/2, 100, 100)
        self.view.addSubview(actInd)
        actInd.hidden = false
        actInd.startAnimating()
        
        //dichiarar in tutte le opzioni
        sideBar = SideBar(sourceView: self.view)
        sideBar.delegate = self
        todayIsAbout.font = UIFont (name: "PlayfairDisplay-Italic", size: 18)
        searchBar.delegate = self
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://23.251.141.230/Catchy/latest/")!)
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
            news = JsonDecoder.decodeNews(responseString)
    
            dispatch_async(dispatch_get_main_queue(),{ self.tableView.reloadData() })
            
            
        })
        
        task.resume()
    }

    
    
    //Table View
    
    func  tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
 
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM. dd yyyy / HH:mm"
        
  
        var cell = tableView.dequeueReusableCellWithIdentifier("NewsCell") as CustomCell
        
        cell.imageBackground.image = news[indexPath.row].image[0]
        cell.imageBackground.clipsToBounds=true
        
        cell.categoryLabel.text = news[indexPath.row].category
        cell.categoryLabel.font = UIFont (name: "Oswald-Regular", size: 16)
        
        cell.dateLabel.text = dateFormatter.stringFromDate(news[indexPath.row].date).uppercaseString
        cell.dateLabel.font = UIFont (name: "Oswald-Regular", size: 16)
        
        
        cell.titleLabel.text = news[indexPath.row].title.uppercaseString
        cell.titleLabel.font = UIFont (name: "Oswald-Regular", size: 18)
        
        actInd.stopAnimating()
        actInd.hidesWhenStopped = true
        
        
        return cell
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showItemDetail" {
            /*
            var actIndDetail:UIActivityIndicatorView = UIActivityIndicatorView()
            actIndDetail.frame = CGRectMake(self.view.frame.width/2-50 , self.view.frame.height/2, 100, 100)
            self.view.addSubview(actIndDetail)
            actIndDetail.hidden = false
            actIndDetail.startAnimating()
*/
            let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow()!
            let detailVC:NotiziaSpecificaVC = segue.destinationViewController as NotiziaSpecificaVC
            detailVC.notizia = news[indexPath.row] as Notizie
           
            
        }
        
        if (segue.identifier == "searchVC") {
            var svc = segue.destinationViewController as SearchVC
            svc.dataPassed = searchBar.text
            svc.countSearch = notizieSearch.count
            //println(searchBar.text)
            for n in notizieSearch{
                println(n.title)
            svc.notizia = n
            }
        }
    }
    

    
    //dichiara in tutte le opzioni
    @IBAction func btnSubmit(sender: AnyObject) {
        sideBar.showSideBar(!sideBar.isSideBarOpen)
    }
    
    
    func sideBarDidSelectButtonAtIndex(index: Int){
        if index == 0{
            self.performSegueWithIdentifier("showFollowedStoriesVC", sender:self)
            
        }
        if index == 1{
            
            self.performSegueWithIdentifier("showMainNewsVC", sender:self)
        }
        
        if index == 2{
            
            self.performSegueWithIdentifier("showCustomizeTopicsVC", sender:self)
        }
        
        if index == 3{
            
            self.performSegueWithIdentifier("showFAQS&HelpVC", sender:self)
        }
        
        if index == 4{
            
            self.performSegueWithIdentifier("showOptionsVC", sender:self)
        }
        
    }
    
    
    @IBAction func searchButton(sender: AnyObject) {
        
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
    
    func searchBarSearchButtonClicked( searchBar2: UISearchBar!){
        notizieSearch = [Notizie]()
        searchBar2.resignFirstResponder()
        do{
        
        }while(news.count==0)
        
        for n in news {
            //println(searchBar2.text)
           // println(n.title)
            if (NSString(string: n.title).localizedCaseInsensitiveContainsString(searchBar2.text) || NSString(string: n.body).localizedCaseInsensitiveContainsString(searchBar2.text)){
                println("OK")
                notizieSearch.append(n)

            }
            println(notizieSearch)
        }
        
        self.performSegueWithIdentifier("searchVC", sender:self)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension String {
    init (htmlEncodedString: String){
        let encodedData = htmlEncodedString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        let attributedOptions = [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType]
        var attributeString:NSAttributedString!
        dispatch_async(dispatch_get_main_queue(),{
                 attributeString = NSAttributedString (data: encodedData!, options: attributedOptions, documentAttributes: nil, error: nil)!
        })

        do{
            
        }while(attributeString == nil)
        
        self.init(attributeString.string)
    }
}