//
//  CheckBox.swift
//  Catchy
//
//  Created by TSC on 27/02/15.
//  Copyright (c) 2015 TSC Consulting. All rights reserved.
//

import UIKit

class CheckBox: UIButton {
    
    
    //images
    
    let checkedImage = UIImage(named: "followed_N")
    let unCheckedImage = UIImage(named: "not_follow")
    
    //bool property
    var isChecked:Bool = false{
        didSet{
            if isChecked == true{
                self.setImage(checkedImage, forState: .Normal)
            }else{
                self.setImage(unCheckedImage, forState: .Normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked(sender:UIButton){
        if(sender == self){
            if isChecked == true{
                isChecked = false
            }else{
                isChecked = true
            }
        }
    }
    
}
