//
//  StudentMainInterface.swift
//  Estaed
//
//  Created by arwa balawi on 15/05/1443 AH.
//

import UIKit

class StudentMainInterface : UIViewController {
  
  

override func viewDidLoad() {
  super.viewDidLoad()
}
  
  
  @IBAction func TwitterButton(_ sender: Any) {
    
    UIApplication.shared.open(URL(string: "https://twitter.com/estaeda?s=21")! as URL, options: [:], completionHandler: nil)
    
  }
  
  
  
}
