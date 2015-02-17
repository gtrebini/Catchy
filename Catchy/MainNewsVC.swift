//
//  MainNewsVC.swift
//  Catchy
//
//  Created by TSC Consulting on 10/02/15.
//  Copyright (c) 2015 TSC Consulting. All rights reserved.
//

import UIKit


var news2 = [Notizie]()



class MainNewsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, SideBarDelegate {
    
    
    var sideBar:SideBar = SideBar()
    
    @IBOutlet weak var todayIsAbout: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet var totalView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
            news2 = JsonDecoder.decodeNews(responseString)
            
            dispatch_async(dispatch_get_main_queue(),{ self.tableView.reloadData() })
            
            
        })

        task.resume()
        
    }

    
    
    //Table View
    func  tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news2.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM. dd yyyy / HH:mm"
        
        var cell = tableView.dequeueReusableCellWithIdentifier("NewsCell") as CustomCell
        
        cell.imageBackground.image = news2[indexPath.row].image[0]
        cell.imageBackground.clipsToBounds=true
        
        cell.categoryLabel.text = news2[indexPath.row].category
        cell.categoryLabel.font = UIFont (name: "Oswald-Regular", size: 16)
        
        cell.dateLabel.text = dateFormatter.stringFromDate(news2[indexPath.row].date).uppercaseString
        cell.dateLabel.font = UIFont (name: "Oswald-Regular", size: 16)
        
        
        cell.titleLabel.text = news2[indexPath.row].title.uppercaseString
        cell.titleLabel.font = UIFont (name: "Oswald-Regular", size: 18)
        
        return cell
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showItemDetail" {
            let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow()!
            let detailVC:NotiziaSpecificaVC = segue.destinationViewController as NotiziaSpecificaVC
            detailVC.notizia = news2[indexPath.row] as Notizie
        }
        
        if (segue.identifier == "searchVC") {
            var svc = segue.destinationViewController as SearchVC;
            svc.dataPassed = searchBar.text
        }
    }

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}