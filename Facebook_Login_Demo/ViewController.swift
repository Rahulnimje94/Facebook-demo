//
//  ViewController.swift
//  Facebook_Login_Demo
//
//  Created by Anand on 09/12/17.
//  Copyright © 2017 Rahul. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

var x: Int?

class ViewController: UIViewController {
    
    let loginManager = FBSDKLoginManager()
    var fbData = [String: AnyObject]()
    var twiData = [String: AnyObject]()
    var lnData = [String: AnyObject]()
    var gData = [String: AnyObject]()
    var image: String?
    var name: String?
    var email: String?

    override func viewDidLoad() {
        super.viewDidLoad()
     
    }

    @IBAction func loginWithFb(_ sender: Any) {
        x = 1
        loginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: self) { (result, error) in
            
            if error != nil
            {
                print("error occured with login \(error?.localizedDescription)")
            }
                
            else if (result?.isCancelled)!
            {
                print("login canceled")
            }
                
            else
            {
                if FBSDKAccessToken.current() != nil
                {
                    
                    FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, userResult, error) in
                        
                        
                        if error != nil
                        {
                            print("error occured \(error?.localizedDescription)")
                        }
                        else if userResult != nil
                        {
                            print("Login with FB is success")
                            print(userResult! as Any)
//                                                        let email = userResult["email"] as? String
                            let email = userResult as? [String:[Any]]
//                                                         let email = result?["email"]
                            print(email as Any)
                            //
                            //                    let img_URL: String = (userResult.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
                            //
//                                                        let email = (userResult.objectForKey("email") as? String)!
                            //                            //                            let password = "1234567890" //(userResult.objectForKey("id") as? String)!
                            //                            let password =  (userResult.objectForKey("id") as? String)!
                            //
                            //                            let name = (userResult.objectForKey("name") as? String)!
                            
                        }
                        
                    })
                }
                
            }
            
        }
        

    }
   
}

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}
