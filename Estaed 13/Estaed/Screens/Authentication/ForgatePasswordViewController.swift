//
//  ForgatePasswordViewController.swift
//  Estaed
//
//  Created by arwa balawi on 10/06/1443 AH.
//

import Foundation
import UIKit
import Firebase

class ForgatePasswordViewController: UIViewController {

  @IBOutlet weak var EmailTextField: UITextField!
  @IBOutlet weak var ForgatePassword: UITextField!
  @IBOutlet weak var SaveBtn: UIButton!
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
       
    }

 

func setUpElements() {
 
  Utilities.styleFilledButton(SaveBtn)
}
  
  @IBAction func forgatePassword(_ sender: Any) {
    

  }
  
    

 

}

