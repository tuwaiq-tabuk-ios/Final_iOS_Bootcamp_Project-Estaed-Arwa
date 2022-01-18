//
//  ViewController.swift
//  Estaed
//
//  Created by arwa balawi on 09/05/1443 AH.
//

import Foundation
import UIKit

class ViewController: UIViewController {
  
  
  @IBOutlet weak var Welcome: UILabel!
  @IBOutlet weak var SignUpButton: UIButton!
  @IBOutlet weak var LoginButton: UIButton!
  
  @IBOutlet weak var lang: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpElements()
  }
  

 // changebtn
  @IBAction func langBtn(_ sender: UISegmentedControl) {
    if lang.selectedSegmentIndex == 0 { //English
      Welcome.text = "Welcome".localizableString(loc: "en")
        
    }else{ //Arabic
      Welcome.text = "Welcome".localizableString(loc: "ar")

      
    }
  }
  
  func setUpElements() {
   
    Utilities.styleFilledButton(SignUpButton)
    Utilities.styleFilledButton(LoginButton)
    
  }


}
