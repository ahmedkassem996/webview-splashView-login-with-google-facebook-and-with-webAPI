//
//  ViewController.swift
//  Webview
//
//  Created by AHMED on 4/2/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import WebKit
import RevealingSplashView

class ViewController: UIViewController {

  @IBOutlet weak var webview: WKWebView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    let url = URL(string: URL_PAGE )
    let request = URLRequest(url: url!)
    
    webview.load(request)
    
  }

  
  
}

