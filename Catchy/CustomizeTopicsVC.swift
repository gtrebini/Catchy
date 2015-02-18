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
    
    var categories:[String]!


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keepAnEyeOnLabel.font = UIFont (name: "PlayfairDisplay-Italic", size: 18)
        
        categories = [String]()
        for n in news {
            if !(contains(categories, n.category)){
               categories.append(n.category)
            }
        }
    }
    
    func  tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CellTopic") as CustomCellTopic
        var viewCell:UIView = UIView()
        
        cell.categoryLabel.text = categories[indexPath.row].uppercaseString
        cell.categoryLabel.font = UIFont (name: "Oswald-Regular", size: 16)

        if (categories[indexPath.row] == "Sport"){
            cell.contentView.backgroundColor = UIColor(red: 167/255, green: 165/255, blue: 166/255, alpha: 1)
            cell.categoryLabel.backgroundColor = UIColor(red: 167/255, green: 165/255, blue: 166/255, alpha: 1)
            
            viewCell.backgroundColor = UIColor(red: 167/255, green: 165/255, blue: 166/255, alpha: 1)
            cell.selectedBackgroundView = viewCell

        }else if (categories[indexPath.row] == "Politica"){
            cell.contentView.backgroundColor = UIColor(red: 221/255, green: 252/255, blue: 208/255, alpha: 1)
            cell.categoryLabel.backgroundColor = UIColor(red: 221/255, green: 252/255, blue: 208/255, alpha: 1)
            
            
            viewCell.backgroundColor = UIColor(red: 221/255, green: 252/255, blue: 208/255, alpha: 1)
            cell.selectedBackgroundView = viewCell
            
        }else if (categories[indexPath.row] == "Scienza"){
            cell.contentView.backgroundColor = UIColor(red: 194/255, green: 195/255, blue: 242/255, alpha: 1)
            cell.categoryLabel.backgroundColor = UIColor(red: 194/255, green: 195/255, blue: 242/255, alpha: 1)
            
            viewCell.backgroundColor = UIColor(red: 194/255, green: 195/255, blue: 242/255, alpha: 1)
            cell.selectedBackgroundView = viewCell
        }
        return cell
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    
}
