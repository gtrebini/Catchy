//
//  File.swift
//  Catchy
//
//  Created by TSC Consulting on 20/01/15.
//  Copyright (c) 2015 TSC Consulting. All rights reserved.
//

import UIKit
import Foundation

class SearchVC: UIViewController, UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate, SideBarDelegate {
    
    
    
    var sideBar:SideBar = SideBar()
    var dataPassed:String!
    var countSearch:Int!
     var actInd:UIActivityIndicatorView!
    
    @IBOutlet weak var labelA: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet var totalView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
   
    var notizia = Notizie (pageid: 0, pageidstoria: 0, pageurl: "", pageurlstoria: "", titlestoria: "", aggiornato: NSDate(),category: "", date: NSDate(), title: "", image: [UIImage](), body: "")
    
    
    
    override func viewDidLoad() {
        

        super.viewDidLoad()
        sideBar = SideBar(sourceView: self.view)
        sideBar.delegate = self
        
        labelA.text = "about: " + dataPassed
        
        searchBar.text = dataPassed
        
    }
    
    
    
    func  tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countSearch
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
     
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM. dd yyyy / HH:mm"
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier("NewsCell") as CustomCell
       
        println(notizieSearch)
        println(notizieSearch.count)
        println(indexPath.row)
        cell.imageBackground.image = notizieSearch[indexPath.row].image[0]
        cell.imageBackground.clipsToBounds=true
        
        cell.categoryLabel.text = notizieSearch[indexPath.row].category
        cell.categoryLabel.font = UIFont (name: "Oswald-Regular", size: 16)
        
        cell.dateLabel.text = dateFormatter.stringFromDate(notizieSearch[indexPath.row].date).uppercaseString
        cell.dateLabel.font = UIFont (name: "Oswald-Regular", size: 16)
        
        
        cell.titleLabel.text = notizieSearch[indexPath.row].title.uppercaseString
        cell.titleLabel.font = UIFont (name: "Oswald-Regular", size: 18)
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showItemDetail2" {
            /*
            var actIndDetail:UIActivityIndicatorView = UIActivityIndicatorView()
            actIndDetail.frame = CGRectMake(self.view.frame.width/2-50 , self.view.frame.height/2, 100, 100)
            self.view.addSubview(actIndDetail)
            actIndDetail.hidden = false
            actIndDetail.startAnimating()
            */
            let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow()!
            println(indexPath)
            let detailVC:NotiziaSpecificaVC = segue.destinationViewController as NotiziaSpecificaVC
            detailVC.notizia = notizieSearch[indexPath.row] as Notizie
            
            
        }
    }

    
    @IBAction func btnSubmit(sender: AnyObject) {
        sideBar.showSideBar(!sideBar.isSideBarOpen)
        if  sideBar.isSideBarOpen == false{
            
            sideBar.sideBarContainerView.hidden = true
        }
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
        var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var vc:SearchVC = storyboard.instantiateViewControllerWithIdentifier("SearchVC") as SearchVC
    
        
        notizieSearch = [Notizie]()
       
        labelA.text = searchBar.text
    
        do{
            
        }while(news.count==0)
        
        for n in news {
            //println(searchBar2.text)
            // println(n.title)
            if (NSString(string: n.title).localizedCaseInsensitiveContainsString(searchBar.text) || NSString(string: n.body).localizedCaseInsensitiveContainsString(searchBar.text)){
                println("OK")
                notizieSearch.append(n)
                
            }
            println(notizieSearch)
        }
        
        for n in notizieSearch {
            vc.notizia = n
        }
        vc.dataPassed = searchBar.text
        vc.countSearch = notizieSearch.count
        navigationController?.pushViewController(vc, animated: true)
    }

    
    
 
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
