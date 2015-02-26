//
//  SignUpVC.swift
//  Catchy
//
//  Created by TSC Consulting on 09/01/15.
//  Copyright (c) 2015 TSC Consulting. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet var usernameTF:UITextField!
    @IBOutlet var passwordTF:UITextField!
    @IBOutlet var signUpButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTF.secureTextEntry = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "SignUpSucessfull" {
            let signInVC:SignInVC = segue.destinationViewController as SignInVC
            
        }
    }
    
    
    @IBAction func signupButtonTapped (sender:UIButton){
        
        var actInd:UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRectMake(self.view.frame.width/2-50 , self.view.frame.height/2, 100, 100)
        self.view.addSubview(actInd)
        actInd.hidden = false
        actInd.startAnimating()
        
        var username:NSString = usernameTF.text as NSString
        var password:NSString = passwordTF.text as NSString
        
        if (username.isEqualToString("") || password.isEqualToString("")){
            actInd.stopAnimating()
            actInd.hidesWhenStopped = true
            var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            var vc:SignUpVC = storyboard.instantiateViewControllerWithIdentifier("SignUp") as SignUpVC
            navigationController?.pushViewController(vc, animated: true)

            var alertView:UIAlertView = UIAlertView()
            alertView.title = "SignUp Failed!"
            alertView.message = "Please enter username and password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
            
            
        }else{
            println(username)
            println(password)
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8888/Catchy/users/?email=\(username)&password=\(password)")!)
            request.HTTPMethod = "GET"
          
            
            //request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(data, response, error)
                in
                
                if error != nil {
                    println("error=\(error)")
                    return
                }
                
                let   responseString = NSString(data: data, encoding: NSUTF8StringEncoding)!
                println("response: \(responseString)")
               
                if(responseString.containsString("User email already registered")){
                    dispatch_async(dispatch_get_main_queue()){
                    var alertView:UIAlertView = UIAlertView()
                        alertView.title = "SignUp Failed!"
                    alertView.message = "Email already exists"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                    var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    var vc:SignUpVC = storyboard.instantiateViewControllerWithIdentifier("SignUp") as SignUpVC
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    actInd.stopAnimating()
                    actInd.hidesWhenStopped = true
                        
                    }
                }else if(responseString.containsString("Saved")){
                    actInd.stopAnimating()
                    actInd.hidesWhenStopped = true
                    dispatch_async(dispatch_get_main_queue()){
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "SignUp!"
                        alertView.message = "SignUp Successfull"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    self.performSegueWithIdentifier("SignUpSucessfull", sender: self)
                    }
                }else if(responseString.containsString("Invalid email address")){
                    dispatch_async(dispatch_get_main_queue()){
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "SignUp Failed!"
                        alertView.message = "Invalid email address"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                        var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        var vc:SignUpVC = storyboard.instantiateViewControllerWithIdentifier("SignUp") as SignUpVC
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                        actInd.stopAnimating()
                        actInd.hidesWhenStopped = true
                        
                    }
                }

              
            })
        task.resume()
            
    }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
