//
//  HomeVC.swift
//  Catchy
//
//  Created by TSC Consulting on 12/01/15.
//  Copyright (c) 2015 TSC Consulting. All rights reserved.
//

import UIKit


var news = [Notizie]()



class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, SideBarDelegate {
    
    
    var sideBar:SideBar = SideBar()
    
    var actInd:UIActivityIndicatorView!
    
    
    
    
    
    
    
    
    @IBOutlet weak var tableViewHomeVC: UITableView!
    
    func  tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return news.count
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "MMM. dd yyyy / HH:mm"
        
        
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier("NewsCell") as CustomCell
        
        cell.imageBackground.image = news[indexPath.row].image
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
    
    /*@IBOutlet weak var myTableView: UITableView
    var arrayOfNotizie: [Notizie] = [Person]()*/
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
   
        actInd = UIActivityIndicatorView()
        actInd.frame = CGRectMake(self.view.frame.width/2-50 , self.view.frame.height/2, 100, 100)
        self.view.addSubview(actInd)
        actInd.hidden = false
        actInd.startAnimating()
        
        //dichiarar in tutte le opzioni
        sideBar = SideBar(sourceView: self.view)
        
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showItemDetail" {
            let indexPath:NSIndexPath = self.tableViewHomeVC.indexPathForSelectedRow()!
            let detailVC:NotiziaSpecificaVC = segue.destinationViewController as NotiziaSpecificaVC
            detailVC.notizia = news[indexPath.row] as Notizie
            
            
        }
        
        if (segue.identifier == "searchVC") {
            var svc = segue.destinationViewController as SearchVC;
            svc.dataPassed = searchBar.text
        }
    }
    

    @IBOutlet weak var todayIsAbout: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewSearch: UIView!
    
    @IBOutlet var totalView: UIView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //dichiara in tutte le opzioni
    @IBAction func btnSubmit(sender: AnyObject) {
        sideBar.showSideBar(!sideBar.isSideBarOpen)
    }
    
    func sideBarDidSelectButtonAtIndex(index: Int){
        if index == 0{
            //cosa voglio fare premendo il primo bottone
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
    
    func searchBarSearchButtonClicked( searchBar: UISearchBar!){
        
        searchBar.resignFirstResponder()
    
        
        self.performSegueWithIdentifier("searchVC", sender:self)
        
    }
    
    
    
}