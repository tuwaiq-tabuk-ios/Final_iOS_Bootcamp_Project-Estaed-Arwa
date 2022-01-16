//
//  SignUpViewController.swift
//  Estaed
//
//  Created by arwa balawi on 09/05/1443 AH.
//

import Foundation
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
  
  //hide the keyboard
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  //
  
  //Transfer to next textfield directly
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    if textField == FirstNameTextField {
      LastNameTextField.becomeFirstResponder()
      
    }else if  textField == LastNameTextField {
      EmailTextField.becomeFirstResponder()
    }else if textField == EmailTextField {
      PasswordTextField.becomeFirstResponder()
    } else {
      //hide the keyboard
      view.endEditing(true)
    }
    
    return true
  }
  
  
  @IBAction func haveAccount(_ sender: Any) {
    let SignUpViewController = self.storyboard?
      .instantiateViewController(identifier:Constant.storyboard.LoginViewController)
       
       self.view.window?.rootViewController = SignUpViewController
       self.view.window?.makeKeyAndVisible()
  }
  

  func setUpElements() {
    
    //Hide the error label
    ErrorLabel.alpha = 0
    
    // style the element

    Utilities.styleTextField(textfield: FirstNameTextField)
    Utilities.styleTextField(textfield: LastNameTextField)
    Utilities.styleTextField(textfield: EmailTextField)
    Utilities.styleTextField(textfield: PasswordTextField)
    Utilities.styleFilledButton(SignUpButton)
    Utilities.styleFilledButton(haveAccount)
  }
  
  //Creat the fields and validate that the data is correct.if everything is correct , this method returns nill.Otherwise , it returns the error message
  func validateFields() -> String? {
    //Check that all fields are filled in
    if FirstNameTextField.text == "" ||
        LastNameTextField.text == "" ||
        EmailTextField.text == "" ||
        PasswordTextField.text == ""
    
        {

      bottomLine.backgroundColor = UIColor.init(red: 155/255, green: 0/255, blue: 0/255, alpha: 1).cgColor

      return "please fill in all fields."
          
    }
     // Check if the password is secure
    let cleanedPassword = PasswordTextField.text!
    //.trimmingCharacters(in: .whitespacesAndNewlines)
    
   if  Utilities.isPasswordValid(cleanedPassword) == false {
     // password isn't secure enough
      return "pleas make sure your password is at least 8 characters, contains a special characters and a number."
    bottomLine.backgroundColor = UIColor.init(red: 155/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
    }
    return nil
  }
  
  
  @IBAction func SignUpTapped(_ sender: Any) {
    //Validate
      let error = validateFields()
      
      if error != nil{
        
      showError(error!)
      } else {
        let firstName =  FirstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = LastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //creat the user
        Auth.auth().createUser(withEmail: email, password: password) { (result ,err)  in
          
          //check for errors
          if err != nil {
            //there was an error creating the user
            //اذا الخطأ ماكان فاضي يعني فيه خطأ 
            self.showError("Error creating user")
           // User(uid: (result?.user.uid)!,
            
          } else{
            
            //اذا مافي خطأ سجل في قاعده البيانات
            let user = User(firstName: self.FirstNameTextField.text!,
                            lasteName: self.LastNameTextField.text!,
                            Password: self.PasswordTextField.text!,
                            email: self.EmailTextField.text!)
            
               //ايش فايدتها 
            self.ref.child("users").child((result?.user.uid)!).setValue([
              "FirstName" : user.firstName,
              "LastName" : user.lasteName,
              "Email" : user.email,
              "password" : user.Password
                  ])

            
  //          let uuid = NSUUID().uuidString
  //          print(uuid)
  //
            
            if error != nil{             // -------------------------------------------
              //show error message
              self.showError("Error saving user data")
            }
          }
          //transition to home screen
              self.transitionToHome()
          
        }
          }
          }
            func showError(_ message:String){
              ErrorLabel.text = message
              ErrorLabel.alpha = 1
            
            }
        
        func transitionToHome(){
          
         let homeViewController =
          storyboard?.instantiateViewController(identifier: "HomeVC")
          
          view.window?.rootViewController =  homeViewController
          view.window?.makeKeyAndVisible()
          
        }
        

}

