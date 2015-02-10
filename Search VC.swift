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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideBar = SideBar(sourceView: self.view)
        
         sideBar.delegate = self
        
        
       labelA.text = "about: " + dataPassed
        
       searchBar.text = dataPassed

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
