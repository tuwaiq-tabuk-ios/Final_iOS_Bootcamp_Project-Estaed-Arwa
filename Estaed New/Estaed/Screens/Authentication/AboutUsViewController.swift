//
//  StudentMainInterface.swift
//  Estaed
//
//  Created by arwa balawi on 15/05/1443 AH.
//

import UIKit

class AboutUsViewController : UIViewController {

override func viewDidLoad() {
  super.viewDidLoad()
}
  //MARK: -fun to switch any link
  @IBAction func twitterButton(_ sender: Any) {
    
    UIApplication.shared.open(URL(string: "https://twitter.com/estaeda?s=21")! as URL,
                              options: [:], completionHandler: nil)
    
  }
}
