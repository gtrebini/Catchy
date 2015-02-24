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
        
        var username:NSString = usernameTF.text
        var password:NSString = passwordTF.text
        
        if ( username.isEqualToString("") || password.isEqualToString("") ) {
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
            
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8888/Catchy/signin.php")!)
            request.HTTPMethod = "POST"
            let postString = "username=\(username)&password=\(password)"
            
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(data, response, error)
                in
                
                if error != nil {
                    println("error=\(error)")
                    return
                }
                
                let   responseString = NSString(data: data, encoding: NSUTF8StringEncoding)!
                println("response: \(responseString)")
                
                if(responseString.containsString("Success")){
                    dispatch_async(dispatch_get_main_queue()){
                        self.performSegueWithIdentifier("SignInSucessfull", sender: self)
                    }
                
                }else if(responseString.containsString("Invalid username/password")){
                     dispatch_async(dispatch_get_main_queue()){
                    var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    var vc:SignInVC = storyboard.instantiateViewControllerWithIdentifier("SignIn") as SignInVC
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign in Failed!"
                    alertView.message = "Incorrect Username and/or Password"
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
