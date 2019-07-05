//
//  Helper.swift
//  Webview
//
//  Created by AHMED on 4/14/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

class Helper: NSObject {
  
  class func restartApp(){
    guard let window = UIApplication.shared.keyWindow else{return}
    let sb = UIStoryboard(name: "Main", bundle: nil)
    var VC:UIViewController
    
    if getApiToken() == nil{
      //go to auth screen
      VC = sb.instantiateInitialViewController()!
    }else{
      // go to main screen
      VC = sb.instantiateViewController(withIdentifier: "Main")
    }
    
    
    window.rootViewController = VC
    UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
  }
  
  class func saveApiToken(token: String){
    // save api token to user defaults
    let def = UserDefaults.standard
    def.setValue(token, forKey:"api_token")
    def.synchronize
    
    restartApp()
  }
  
  class func getApiToken() -> String?{
    let def = UserDefaults.standard
    return def.object(forKey: "api_token") as? String
  }

}
