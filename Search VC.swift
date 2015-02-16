//
//  File.swift
//  Catchy
//
//  Created by TSC Consulting on 20/01/15.
//  Copyright (c) 2015 TSC Consulting. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UITableViewDelegate,UISearchBarDelegate, SideBarDelegate {
    
    var sideBar:SideBar = SideBar()
    
    @IBOutlet weak var labelA: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet var totalView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideBar = SideBar(sourceView: self.view)
        sideBar.delegate = self
        
        labelA.text = "about: " + dataPassed
        
        searchBar.text = dataPassed
        
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
        
        
        
        return cell
        
    }

    
    @IBAction func btnSubmit(sender: AnyObject) {
        sideBar.showSideBar(!sideBar.isSideBarOpen)
    }
    
    
   /* override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
      
        if (segue.identifier == "showFollowedStoriesVC") {
            var svc = segue.destinationViewController as FollowedStoriesVC;
            
        }
    }*/

   func sideBarDidSelectButtonAtIndex(index: Int) {
        if index == 0{
         
           
            
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
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        labelA.text = searchBar.text
    
    }
    
    
    var dataPassed:String!
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
