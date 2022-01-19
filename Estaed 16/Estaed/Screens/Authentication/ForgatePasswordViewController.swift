//
//  ForgatePasswordViewController.swift
//  Estaed
//
//  Created by arwa balawi on 10/06/1443 AH.
//

import UIKit
import Firebase

class ForgatePasswordViewController: UIViewController {

  @IBOutlet weak var EmailTextField: UITextField!
  @IBOutlet weak var SaveBtn: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
       
    }
  
  
  func setUpElements() {
  
    //Style the element
    Utilities.styleFilledButton(SaveBtn)
    Utilities.styleTextField(textfield: EmailTextField)
    
  }
  
  
  @IBAction func forgatePassword(_ sender: Any) {
    
    let auth = Auth.auth()
    
    auth.sendPasswordReset(withEmail: EmailTextField.text!)
    {
      (error) in
      if let error = error {
        
        Constant.getMsg(title:"Error!".localized,Msg: "error while Getting Data".localized, context: self)
      return
      }
    
      Constant.getMsg(title:"Hurry".localized,Msg:"A password reset email has been sent!".localized, context: self)
    }
  }
  
  @IBAction func dismissButton( sender: UIButton) {
    
    let homeViewController =
     storyboard?.instantiateViewController(identifier: Constant.storyboard.LoginViewController)
     
     view.window?.rootViewController =  homeViewController
     view.window?.makeKeyAndVisible()
     
        
    

  }

}



