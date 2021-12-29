//
//  ViewController.swift
//  Estaed
//
//  Created by arwa balawi on 09/05/1443 AH.
//

import Foundation
import UIKit

class ViewController: UIViewController {
  
  
  @IBOutlet weak var SignUpButton: UIButton!
  
  
  @IBOutlet weak var LoginButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setUpElements()
  }
  
  func setUpElements() {
   
    Utilities.styleFilledButton(SignUpButton)
    Utilities.styleFilledButton(LoginButton)
    
  }


}
