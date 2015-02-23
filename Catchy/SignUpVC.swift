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
        
        var username:NSString = usernameTF.text as NSString
        var password:NSString = passwordTF.text as NSString
        
        if (username.isEqualToString("") || password.isEqualToString("")){
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
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8888/Catchy/signup.php")!)
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
