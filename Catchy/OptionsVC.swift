//
//  OptionsVC.swift
//  Catchy
//
//  Created by TSC on 27/02/15.
//  Copyright (c) 2015 TSC Consulting. All rights reserved.
//



import UIKit

class OptionsVC: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        tapRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapRecognizer)
        
    }
    
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
        
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        var dateformatter = NSDateFormatter()
        dateformatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateTextField.text = dateformatter.stringFromDate(sender.date)
    }
    
    @IBOutlet weak var dateTextField: UITextField!
   
    
    @IBAction func textFieldEditing(sender: UITextField) {
        var datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Time
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
   
    
   
    
    
}
