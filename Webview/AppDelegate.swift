//
//  AppDelegate.swift
//  Webview
//
//  Created by AHMED on 4/2/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
  
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    if let error = error{
      debugPrint("Could not login with google: \(error)")
    }else{
      guard let controller = GIDSignIn.sharedInstance()?.uiDelegate as? LoginVC else{return}
      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
      controller.firebaseLogin(credential)
    }
    
    if GIDSignIn.sharedInstance().hasAuthInKeychain() {
      /* Code to show your tab bar controller */
      print("user is signed in")
      let sb = UIStoryboard(name: "Main", bundle: nil)
      if let tabBarVC = sb.instantiateViewController(withIdentifier: "Home") as? ViewController {
        self.window!.rootViewController = tabBarVC
        self.window?.makeKeyAndVisible()
      }
    } else {
      print("user is NOT signed in")
      /* code to show your login VC */
      let sb = UIStoryboard(name: "Main", bundle: nil)
      if let tabBarVC = sb.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
        self.window!.rootViewController = tabBarVC
        self.window?.makeKeyAndVisible()
      }
    }
    
  }
  
  var navigationController: UINavigationController!
  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    
   
    if let api_token = Helper.getApiToken(){
      print("api_token: \(api_token)")
      // skip auth screen and go to web view
      let tap = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home")
      window?.rootViewController = tap
    }
    
    // google
    GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
    GIDSignIn.sharedInstance()?.delegate = self
    
    // facebook
    FBSDKApplicationDelegate.sharedInstance()?.application(application, didFinishLaunchingWithOptions: launchOptions)

    
    return true
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    let returnGoogle = GIDSignIn.sharedInstance()?.handle(url, sourceApplication:
      options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation:
      UIApplication.OpenURLOptionsKey.annotation)
    let returnFB = FBSDKApplicationDelegate.sharedInstance()?.application(app, open: url,options: options)
    
    return returnGoogle! || returnFB!
  }
  
  
  
  

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}



