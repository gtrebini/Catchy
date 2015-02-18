//
//  CustomCellTopic.swift
//  Catchy
//
//  Created by TSC Consulting on 18/02/15.
//  Copyright (c) 2015 TSC Consulting. All rights reserved.
//

import UIKit

class CustomCellTopic: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
   
    @IBOutlet weak var imageFollow: UIImageView!
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
            }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}