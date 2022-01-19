//
//  LoginViewController.swift
//  EstaedUITests
//
//  Created by arwa balawi on 09/05/1443 AH.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController,UITextFieldDelegate {

  
  @IBOutlet weak var EmailTextField: UITextField!
  @IBOutlet weak var PasswordTextField: UITextField!
  @IBOutlet weak var LoginButton: UIButton!
  @IBOutlet weak var ErrorLabel: UILabel!
  var iconClick = false
  let imageicon = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    EmailTextField.delegate = self
    PasswordTextField.delegate = self
    
    setUpElements()
    
    imageicon.image = UIImage(named: "closeEye")
    
    let contentView = UIView()
    contentView.addSubview(imageicon)
    
    contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "closeEye")!.size.width, height: UIImage(named: "closeEye")!.size.height)
    
    imageicon.frame = CGRect(x: -10, y: 0, width: UIImage(named: "closeEye")!.size.width, height: UIImage(named: "closeEye")!.size.height)
    
    PasswordTextField.rightView = contentView
    PasswordTextField.rightViewMode = .always
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
    imageicon.isUserInteractionEnabled = true
    imageicon.addGestureRecognizer(tapGestureRecognizer)
  }
  
  
  @IBAction func forgatePassword(_ sender: Any) {
    
    
    let LoginViewController = self.storyboard?.instantiateViewController(identifier: Constant.storyboard.ForgatePassword)

   self.view.window?.rootViewController = LoginViewController
      self.view.window?.makeKeyAndVisible()
//    self.performSegue(withIdentifier: "ForgatePasswordViewController", sender: nil)
  }
  
  
   
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == EmailTextField {
      PasswordTextField.becomeFirstResponder()
    } else {
      //hide the keyboard
      view.endEditing(true)
    }
    return true
  }


  
  @objc func imageTapped (tapGestureRecognizer:UITapGestureRecognizer)
  {
    let tappedImage = tapGestureRecognizer.view as! UIImageView
    
    if iconClick
    {
      iconClick = false
      tappedImage.image = UIImage(named: "openEye")
      PasswordTextField.isSecureTextEntry = false
    }
    else
    {
      iconClick = true
      tappedImage.image = UIImage(named: "closeEye")
      PasswordTextField.isSecureTextEntry = true
      
    }
   
  }
  
  
  @IBAction func haveAccount(_ sender: Any) {
    let LoginViewController = self.storyboard?
      .instantiateViewController(identifier:Constant.storyboard.SignUpViewController)
        
        self.view.window?.rootViewController = LoginViewController
        self.view.window?.makeKeyAndVisible()
  }
  
  
  func setUpElements() {
    
    //Hide the error label
//    ErrorLabel.alpha = 0
    
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
          self.storyboard?.instantiateViewController(identifier:Constant.storyboard.HomViewController) as? HomViewController
         
        self.view.window?.rootViewController =  homeViewController
        self.view.window?.makeKeyAndVisible()
        
        
      }
    }
  }
  

}
