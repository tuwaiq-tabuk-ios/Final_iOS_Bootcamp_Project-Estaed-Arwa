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

class SignUpViewController : UIViewController,UITextFieldDelegate{

  @IBOutlet weak var FirstNameTextField: UITextField!
  @IBOutlet weak var LastNameTextField: UITextField!
  @IBOutlet weak var EmailTextField: UITextField!
  @IBOutlet weak var PasswordTextField: UITextField!
  @IBOutlet weak var SignUpButton: UIButton!
  @IBOutlet weak var ErrorLabel: UILabel!
  @IBOutlet weak var haveAccount: UIButton!
  let bottomLine = CALayer()
  var ref : DatabaseReference!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    FirstNameTextField.delegate = self
    LastNameTextField.delegate = self
    EmailTextField.delegate = self
    PasswordTextField.delegate = self

   setUpElements()
    ref = Database.database().reference()
  }
  
  
  //MARK: -Transfer to next textfield directly
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == FirstNameTextField {
      LastNameTextField.becomeFirstResponder()
      
    }else if  textField == LastNameTextField {
      EmailTextField.becomeFirstResponder()
    }else if textField == EmailTextField {
      PasswordTextField.becomeFirstResponder()
    } else {
      //MARK: -hide the keyboard
      view.endEditing(true)
    }
    return true
  }
  
  //MARK: -Programmatically switch to another interface
  @IBAction func haveAccount(_ sender: Any) {
    let SignUpViewController = self.storyboard?
      .instantiateViewController(identifier:Constant.storyboard.LoginViewController)
       
       self.view.window?.rootViewController = SignUpViewController
       self.view.window?.makeKeyAndVisible()
  }
  
  //MARK: -design label,textField and button By call Utilities class
  func setUpElements() {
    
    //Too: Hide the error label
    ErrorLabel.alpha = 0
    //Too: style the element
    Utilities.styleTextField(textfield: FirstNameTextField)
    Utilities.styleTextField(textfield: LastNameTextField)
    Utilities.styleTextField(textfield: EmailTextField)
    Utilities.styleTextField(textfield: PasswordTextField)
    Utilities.styleFilledButton(SignUpButton)
    Utilities.styleFilledButton(haveAccount)
  }
  
  //MARK: -Verify that the entries are correct  
  func validateFields() -> String? {
    //Check that all fields are filled in
    if FirstNameTextField.text == "" ||
        LastNameTextField.text == "" ||
        EmailTextField.text == "" ||
        PasswordTextField.text == ""
        {
          //Too: Change borderColor
            let myColor = UIColor.red
            PasswordTextField.layer.borderColor = myColor.cgColor
            PasswordTextField.layer.borderWidth = 1.0
            FirstNameTextField.layer.borderColor = myColor.cgColor
            FirstNameTextField.layer.borderWidth = 1.0
            LastNameTextField.layer.borderColor = myColor.cgColor
            LastNameTextField.layer.borderWidth = 1.0
            EmailTextField.layer.borderColor = myColor.cgColor
            EmailTextField.layer.borderWidth = 1.0
            
      return "please fill in all fields.".localized
    }
    
     // Check if the password is secure
    let cleanedPassword = PasswordTextField.text!
   if  Utilities.isPasswordValid(cleanedPassword) == false {
    let myColor = UIColor.white
    FirstNameTextField.layer.borderColor = myColor.cgColor
    FirstNameTextField.layer.borderWidth = 1.0
    LastNameTextField.layer.borderColor = myColor.cgColor
    LastNameTextField.layer.borderWidth = 1.0
    EmailTextField.layer.borderColor = myColor.cgColor
    EmailTextField.layer.borderWidth = 1.0
    
    let myColor2 = UIColor.red
    PasswordTextField.layer.borderColor = myColor2.cgColor
    PasswordTextField.layer.borderWidth = 1.0
     // password isn't secure enough
    return "pleas make sure your password is at least 8 characters, contains a special characters and a number.".localized
    }
    return nil
  }
  
  //MARK: -get data to Firbase
  @IBAction func SignUpTapped(_ sender: Any) {
    //Too: Validate
      let error = validateFields()
      
      if error != nil{
        
      showError(error!)
      }else {
       
        let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Too: creat the user
        Auth.auth().createUser(withEmail: email, password: password) { (result ,err)  in
          //Too: check for errors
          if err != nil {
            
            //Too: there was an error creating the user
            self.showError("Error creating user")
          }else {
            //Too: If there is no error, save the database
            let user = User(firstName: self.FirstNameTextField.text!,
                            lastName:  self.LastNameTextField.text!,
                            email: self.EmailTextField.text!,
                            imageUrl: "",
                            userType: 2)
          
      
            self.ref.child("users").child((result?.user.uid)!).setValue(user.toDic())
            { error , data in
              
              if error != nil{
                //Too: show error message
                self.showError("Error saving user data")
              }else
              {
                Constant.StudentId = result!.user.uid
                Constant.navigateToUserScreen(context: self.navigationController!)
              }
            }
          }
        }
      }
    }
  
  //MARK: -func for show text error
  func showError(_ message:String) {
              ErrorLabel.text = message
              ErrorLabel.alpha = 1
  }
  
//MARK: -Programmatically switch to another interface
func transitionToHome(){
let homeViewController =  storyboard?.instantiateViewController(identifier: "HomeVC")
         
view.window?.rootViewController =  homeViewController
view.window?.makeKeyAndVisible()
          
  }
}


