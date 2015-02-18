//
//  CustomizeTopics.swift
//  Catchy
//
//  Created by TSC Consulting on 18/02/15.
//  Copyright (c) 2015 TSC Consulting. All rights reserved.
//

import UIKit
import Foundation


class CustomizeTopicsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var totalView: UIView!
    @IBOutlet var keepAnEyeOn: UIView!
    @IBOutlet var keepAnEyeOnLabel: UILabel!
    @IBOutlet var tableView: UITableView!


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func  tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
           var cell = tableView.dequeueReusableCellWithIdentifier("CellTopic") as CustomCellTopic
        println(cell)
        cell.categoryLabel.text = "Ciao"
        return cell
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    
}
