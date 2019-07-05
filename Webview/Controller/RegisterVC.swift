//
//  RegisterVC.swift
//  Webview
//
//  Created by AHMED on 4/9/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterVC: UIViewController {

  @IBOutlet weak var userNameTextField: UITextField!
  @IBOutlet weak var emailTxtField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var confirmPasswordTxtField: UITextField!
  
  override func viewDidLoad() {
        super.viewDidLoad()

    }
  @IBAction func cancelBtn(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func registerPressed(_ sender: Any) {
    guard let name = userNameTextField.text?.trimmed, !name.isEmpty, let email = emailTxtField.text?.trimmed, !email.isEmpty, let password  = passwordTextField.text, !password.isEmpty, let passwordAgain = confirmPasswordTxtField.text, !passwordAgain.isEmpty else {return}
    guard password == passwordAgain else{return}
    
    API.register(name: name, email: email, password: password) { (error: Error?, success: Bool) in
      if success{
        print("Register succeed !!")
      }
    }
  }
  
}
