//
//  LoginViewController.swift
//  EstaedUITests
//
//  Created by arwa balawi on 09/05/1443 AH.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

  
  @IBOutlet weak var EmailTextField: UITextField!
  
  
  @IBOutlet weak var PasswordTextField: UITextField!
  
  
  @IBOutlet weak var LoginButton: UIButton!
  
  
  @IBOutlet weak var ErrorLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setUpElements()
  }
  
  func setUpElements() {
    
    //Hide the error label
    ErrorLabel.alpha = 0
    
    //Style the element
    Utilities.styleTextField(textfield: EmailTextField)
    Utilities.styleTextField(textfield: PasswordTextField)
    Utilities.styleFilledButton(LoginButton)
    
  }
  
  
  @IBAction func LoginTapped(_ sender: Any) {
    
    // TOOO : validate text field
    
    //Create cleaned versions of the text field
    let email = EmailTextField.text!
    let password = PasswordTextField.text!
    
    
    //Signin in the user
    Auth.auth().signIn(withEmail: email , password: password) { result, err in
      
      if err != nil {
        
        //Couldn't sign in
        self.ErrorLabel.text = err!.localizedDescription
        self.ErrorLabel.alpha = 1
      }
      else {
        //sign in successfully
        let homeViewController =
          self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homViewController) as? HomViewController
         
        self.view.window?.rootViewController =  homeViewController
        self.view.window?.makeKeyAndVisible()
        
        
      }
    }
  }
  

}
