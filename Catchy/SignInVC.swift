//
//  SignInVC.swift
//  Catchy
//
//  Created by TSC Consulting on 08/01/15.
//  Copyright (c) 2015 TSC Consulting. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    
    @IBOutlet var usernameTF:UITextField!
    @IBOutlet var passwordTF:UITextField!
    @IBOutlet var signInButton:UIButton!
    
    //per la login
    var path:String!
    var fileManager:NSFileManager!

    override func viewDidLoad() {
        super.viewDidLoad()
         passwordTF.secureTextEntry = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "SignInSucessfull" {
            let homeVC:HomeVC = segue.destinationViewController as HomeVC
            
        }
    }
    
    
    @IBAction func signInButtonTapped (sender:UIButton){
        var actInd:UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRectMake(self.view.frame.width/2-50 , self.view.frame.height/2+60, 100, 100)
        self.view.addSubview(actInd)
        actInd.hidden = false
        actInd.startAnimating()

        
        var username:NSString = usernameTF.text
        var password:NSString = passwordTF.text
        
        if ( username.isEqualToString("") || password.isEqualToString("") ) {
            actInd.stopAnimating()
            actInd.hidesWhenStopped = true
            var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            var vc:SignInVC = storyboard.instantiateViewControllerWithIdentifier("SignIn") as SignInVC
            navigationController?.pushViewController(vc, animated: true)
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
            
        } else {
            

            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8888/Catchy/login/?email=\(username)&password=\(password)")!)
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
                
                if(responseString.containsString("Logged")){
                    dispatch_async(dispatch_get_main_queue()){
                        self.performSegueWithIdentifier("SignInSucessfull", sender: self)
                        
                        actInd.stopAnimating()
                        actInd.hidesWhenStopped = true
                        
                        let paths=NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, .UserDomainMask, true)
                        let documentsDirectory = paths[0] as NSString
                        self.path=documentsDirectory.stringByAppendingPathComponent("LoginFile.plist")
                        self.fileManager = NSFileManager.defaultManager()
                        var cred:String = username+"_"+password+"\n"
                        if(!self.fileManager.fileExistsAtPath(self.path)){
                            self.fileManager.createFileAtPath(self.path, contents: nil, attributes: nil)
                            var content:NSData = cred.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
                            content.writeToFile(self.path, atomically: true)
                        }else{
                            self.fileManager.removeItemAtPath(self.path, error: nil)
                            self.fileManager.createFileAtPath(self.path, contents: nil, attributes: nil)
                            var content:NSData = cred.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
                            content.writeToFile(self.path, atomically: true)
                        }
                        
                    }
                
                }else if(responseString.containsString("Invalid email address")){
                    actInd.stopAnimating()
                    actInd.hidesWhenStopped = true
                     dispatch_async(dispatch_get_main_queue()){
                    var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    var vc:SignInVC = storyboard.instantiateViewControllerWithIdentifier("SignIn") as SignInVC
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign in Failed!"
                    alertView.message = "Invalid email address"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                    self.navigationController?.pushViewController(vc, animated: true)
                 }

                }else if(responseString.containsString("Login Failed")){
                    actInd.stopAnimating()
                    actInd.hidesWhenStopped = true
                    dispatch_async(dispatch_get_main_queue()){
                        var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        var vc:SignInVC = storyboard.instantiateViewControllerWithIdentifier("SignIn") as SignInVC
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign in"
                        alertView.message = "Login Failed"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                        self.navigationController?.pushViewController(vc, animated: true)
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
