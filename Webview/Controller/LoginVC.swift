//
//  LoginVC.swift
//  Webview
//
//  Created by AHMED on 4/9/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import RevealingSplashView
import FBSDKLoginKit
import Alamofire
import SwiftyJSON

class LoginVC: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate {
  
  @IBOutlet weak var emailTxtField: UITextField!
  @IBOutlet weak var passwordTxtField: UITextField!
  
  @IBOutlet weak var facebookLogin: FBSDKLoginButton!
  let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "launchScreenIcon")!, iconInitialSize: CGSize(width: 80, height: 80), backgroundColor: UIColor.white)
  
  let loginManager = FBSDKLoginManager()

    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      self.view.addSubview(revealingSplashView)
      revealingSplashView.animationType = SplashAnimationType.woobleAndZoomOut
      revealingSplashView.startAnimation()
      
      revealingSplashView.heartAttack = true
      
      GIDSignIn.sharedInstance()?.uiDelegate = self
      NotificationCenter.default.addObserver(self, selector: #selector(didSignIn), name: NSNotification.Name("SuccessfulSignInNotification"), object: nil)
      
      facebookLogin.delegate = self
      facebookLogin.readPermissions = ["email"]
    }
  
  
  // facebook
  func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    if let error = error{
      debugPrint("Failed facebook login", error)
      return
    }
    
    let credential = FacebookAuthProvider.credential(withAccessToken: result.token.tokenString)
    firebaseLogin(credential)
  }
  
  func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    
  }
  
  @IBAction func customFacebookTapped(_ sender: Any) {
    loginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
      if let error = error{
        debugPrint("Could not login facebook", error)
      }else if result!.isCancelled{
        print("Facebook login was cancled")
      }else{
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        self.firebaseLogin(credential)

      }
    }
  }
  
  
  
  
  @objc func didSignIn()  {
    
    navigationController?.pushViewController(ViewController(), animated: true)
    
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  //firebase
  @IBAction func logoutBtn(_ sender: Any) {
    let firebaseAuth = Auth.auth()
    do{
      logoutSocial()
      try firebaseAuth.signOut()
    }catch let signoutError as NSError{
      debugPrint("Error signing out", signoutError)
    }
  }
  
  // google
  @IBAction func googleSignTapped(_ sender: Any) {
    GIDSignIn.sharedInstance()?.signIn()
  }
  
  func firebaseLogin(_ credential: AuthCredential){
    Auth.auth().signIn(with: credential) { (user, error) in
      if let error = error{
        debugPrint(error.localizedDescription)
        return
      }else{
        self.dismiss(animated: false, completion: nil)
                // Present the main view
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Home") {
        UIApplication.shared.keyWindow?.rootViewController = viewController
        self.dismiss(animated: true, completion: nil)
        }
      }
    }
  }
  
  
  func logoutSocial(){
    guard let user = Auth.auth().currentUser else {return}
    for info in (user.providerData){
      switch info.providerID{
      case GoogleAuthProviderID:
        GIDSignIn.sharedInstance()?.signOut()
        print("google")
      case TwitterAuthProviderID:
        print("twitter")
      case FacebookAuthProviderID:
        loginManager.logOut()
        print("facebook")
      default:
        break
      }
      
    }
  }
  
  func signIn(signIn: GIDSignIn!,
              presentViewController viewController: UIViewController!) {
    self.present(viewController, animated: true, completion: nil)
  }
  
  // Dismiss the "Sign in with Google" view
  func signIn(signIn: GIDSignIn!,
              dismissViewController viewController: UIViewController!) {
    self.dismiss(animated: true, completion: nil)
  }
  
  // login with Alamofire
  @IBAction func loginBtnTapped(_ sender: Any) {
    guard let email = emailTxtField.text, !email.isEmpty else { return }
    guard let password = passwordTxtField.text, !password.isEmpty else { return }
    
    API.login(email: email, password: password) { (error:Error?, success: Bool) in
      if success{
        
      }else{
        
      }
    }
 
  }
  
  
}


