//
//  String+Extensions.swift
//  Webview
//
//  Created by AHMED on 4/13/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import Foundation


extension String{
  
  var trimmed: String{
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}
