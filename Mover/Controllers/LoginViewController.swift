//
//  LoginViewController.swift
//  Mover
//
//  Created by IHSOFT on 2015. 5. 15..
//  Copyright (c) 2015년 IHSOFT. All rights reserved.
//

import UIKit

// Google+
import AddressBook
import MediaPlayer
import AssetsLibrary
import CoreLocation
import CoreMotion

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, GPPSignInDelegate {
    @IBOutlet weak var facebookButton: FBSDKLoginButton!
    @IBOutlet weak var googleplusButton: GPPSignInButton!
    
    var gpSignIn : GPPSignIn = GPPSignIn.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Facebook login permission
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            // User is alread login in, do work such as go to next view controller
            println("Already facebook login")
            returnFBUserData()
        } else {
            facebookButton.readPermissions = ["public_profile", "email", "user_friends"]
            facebookButton.delegate = self
        }
        // end Facebook
        
        // Configre Google login
        googleplusButton.style = kGPPSignInButtonStyleWide
//        googleplusButton.colorScheme = kGPPSignInButtonColorSchemeDark
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        gpSignIn.clientID = appDelegate.GOOGLE_CLIENT_ID;
        gpSignIn.shouldFetchGooglePlusUser = true
        gpSignIn.shouldFetchGoogleUserEmail = true

        gpSignIn.scopes = ["profile"]
        println("gpSignIn.scopes \(gpSignIn.scopes)")
        gpSignIn.delegate = self
        
        if  (gpSignIn.trySilentAuthentication()) {
            println("Already Google+ login")
            
        } else {


        }
        
        println("\(googleplusButton.frame)")    ///DEL
        // End Google+

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonJumpIn(sender: AnyObject) {
        // 건너뛰기 -> 메인화면으로 이동
    }
    
    @IBAction func buttonFacebook(sender: AnyObject) {
        // 페에스북 로그인
    }
    
    @IBAction func buttonGoogle(sender: AnyObject) {
        // 구글플러스 로그인
    }
    
    @IBAction func buttonSignUp(sender: AnyObject) {
        // 회원가입
    }
    
    @IBAction func buttonLogIn(sender: AnyObject) {
        // 로그인
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // Function for Facebook
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        NSLog("\(__FUNCTION__)")
        
        if ((error) != nil) {
            // Process error
            println("Error : \(error)")
        } else if result.isCancelled {
            // Handle cancellations
            println("Facebook login cancel")
        } else {
            // If you ask for multiple permissions at once, you shuld check if specific permission missig
            if result.grantedPermissions.contains("email") {
                // Do work
                returnFBUserData();

            }
            
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        NSLog("\(__FUNCTION__)")
    }
    
    // Return Facebook user data
    func returnFBUserData() {
        let grapRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        grapRequest.startWithCompletionHandler({(connection, result, error) -> Void in
            if (error != nil) {
                // Process error
                println("Error : \(error)")
            } else {
                println("fetched user : \(result)")
                let userName = result.valueForKey("name") as! String
                println("User Name : \(userName)")
                let userEmail = result.valueForKey("email") as! String
                println("User Email : \(userEmail)")
            }
        })
        
    }
    // end - Function for Facebook

    // Function for Google+
    func finishedWithAuth(auth: GTMOAuth2Authentication!, error: NSError!) {
        NSLog("\(__FUNCTION__)")
        NSLog("Received error \(error) and auth object \(auth)")
        
        if (error != nil) {
        
        } else {
            println("Google+ User name : \(gpSignIn.googlePlusUser), Email : \(gpSignIn.authentication.userEmail)")
            
            var displayName = gpSignIn.googlePlusUser.displayName as? String
 //           var aboutMe = gpSignIn.googlePlusUser.aboutMe as! String
            println("displayName : \(displayName)")
        }
    }
    // end - Function for Google+
}
