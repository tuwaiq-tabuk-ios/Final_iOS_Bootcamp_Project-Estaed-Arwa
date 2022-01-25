//
//  SignUpViewController.swift
//  Estaed
//
//  Created by arwa balawi on 09/05/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseCore

class SignUpViewController : UIViewController, UITextFieldDelegate{

  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var signUpButton: UIButton!
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var haveAccount: UIButton!
  
  let bottomLine = CALayer()
  var ref : DatabaseReference!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    firstNameTextField.delegate = self
    lastNameTextField.delegate = self
    emailTextField.delegate = self
    passwordTextField.delegate = self

   setUpElements()
    ref = Database.database().reference()
  }
  
  
  //MARK: -Transfer to next textfield directly
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == firstNameTextField {
      lastNameTextField.becomeFirstResponder()
      
    }else if  textField == lastNameTextField {
      emailTextField.becomeFirstResponder()
    }else if textField == emailTextField {
      passwordTextField.becomeFirstResponder()
    } else {
      //MARK: -hide the keyboard
      view.endEditing(true)
    }
    return true
  }
  
  //MARK: -Programmatically switch to another interface
  @IBAction func haveAccount(_ sender: Any) {
    let signUpViewController = self.storyboard?
      .instantiateViewController(identifier:K.Storyboard.loginViewController)
       
       self.view.window?.rootViewController = signUpViewController
       self.view.window?.makeKeyAndVisible()
  }
  
  //MARK: -design label,textField and button By call Utilities class
  func setUpElements() {
    
    //Too: Hide the error label
    errorLabel.isHidden = true
    //Too: style the element
    Utilities.styleTextField(textfield: firstNameTextField)
    Utilities.styleTextField(textfield: lastNameTextField)
    Utilities.styleTextField(textfield: emailTextField)
    Utilities.styleTextField(textfield: passwordTextField)
    Utilities.styleFilledButton(signUpButton)
    Utilities.styleFilledButton(haveAccount)
  }
  
  //MARK: -Verify that the entries are correct  
  func validateFields() -> String? {
    //Check that all fields are filled in
    if firstNameTextField.text == "" ||
        lastNameTextField.text == "" ||
        emailTextField.text == "" ||
        passwordTextField.text == ""
        {
          //Too: Change borderColor
            let myColor = UIColor.red
            passwordTextField.layer.borderColor = myColor.cgColor
            passwordTextField.layer.borderWidth = 1.0
            firstNameTextField.layer.borderColor = myColor.cgColor
            firstNameTextField.layer.borderWidth = 1.0
            lastNameTextField.layer.borderColor = myColor.cgColor
            lastNameTextField.layer.borderWidth = 1.0
            emailTextField.layer.borderColor = myColor.cgColor
            emailTextField.layer.borderWidth = 1.0
            
      return "please fill in all fields.".localized
    }
    
     // Check if the password is secure
    let cleanedPassword = passwordTextField.text!
   if  Utilities.isPasswordValid(cleanedPassword) == false {
    let myColor = UIColor.white
    firstNameTextField.layer.borderColor = myColor.cgColor
    firstNameTextField.layer.borderWidth = 1.0
    lastNameTextField.layer.borderColor = myColor.cgColor
    lastNameTextField.layer.borderWidth = 1.0
    emailTextField.layer.borderColor = myColor.cgColor
    emailTextField.layer.borderWidth = 1.0
    
    let myColor2 = UIColor.red
    passwordTextField.layer.borderColor = myColor2.cgColor
    passwordTextField.layer.borderWidth = 1.0
     // password isn't secure enough
    return "pleas make sure your password is at least 8 characters, contains a special characters and a number.".localized
    }
    return nil
  }
  
  //MARK: -get data to Firbase
  @IBAction func signUpTapped(_ sender: Any) {
    //Too: Validate
      let error = validateFields()
      if error != nil{
        
      showError(error!)
      }else {
       
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Too: creat the user
        Auth.auth().createUser(withEmail: email, password: password) { (result ,err)  in
          //Too: check for errors
          if err != nil {
            
            //Too: there was an error creating the user
            self.showError("Error creating user")
          }else {
            //Too: If there is no error, save the database
            let user = User(firstName: self.firstNameTextField.text!,
                            lastName:  self.lastNameTextField.text!,
                            email: self.emailTextField.text!,
                            imageUrl: "",
                            userType: 2)
          
      
            self.ref.child("users").child((result?.user.uid)!).setValue(user.toDic())
            { error , data in
              
              if error != nil{
                //Too: show error message
                self.showError("Error saving user data")
              }else
              {
                K.RealtimeDatabase.studentId = result!.user.uid
                K.navigateToUserScreen(context: self.navigationController!)
              }
            }
          }
        }
      }
    }
  
  //MARK: -func for show text error
  func showError(_ message:String) {
              errorLabel.text = message
              errorLabel.alpha = 1
  }
  
  
//
////MARK: -Programmatically switch to another interface
//func transitionToHome(){
//let homeViewController =  storyboard?.instantiateViewController(identifier: "HomeVC")
//
//view.window?.rootViewController =  homeViewController
//view.window?.makeKeyAndVisible()
//
//  }
}


