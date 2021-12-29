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

class SignUpViewController : UIViewController {

  @IBOutlet weak var FirstNameTextField: UITextField!
  @IBOutlet weak var LastNameTextField: UITextField!
  @IBOutlet weak var EmailTextField: UITextField!
  @IBOutlet weak var PasswordTextField: UITextField!
  @IBOutlet weak var SignUpButton: UIButton!
  @IBOutlet weak var ErrorLabel: UILabel!
  var ref : DatabaseReference!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
   setUpElements()
    
    ref = Database.database().reference()
   
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
  }
  
  //Creat the fields and validate that the data is correct.if everything is correct , this method returns nill.Otherwise , it returns the error message
  func validateFields() -> String? {
    //Check that all fields are filled in
    if FirstNameTextField.text == "" ||
        LastNameTextField.text == "" ||
        EmailTextField.text == "" ||
        PasswordTextField.text == ""
    
        {
      

      return "please fill in all fields."
          
    }
     // Check if the password is secure
    let cleanedPassword = PasswordTextField.text!
    //.trimmingCharacters(in: .whitespacesAndNewlines)
    
   if  Utilities.isPasswordValid(cleanedPassword) == false {
     // password isn't secure enough
      return "pleas make sure your password is at least 8 characters, contains a special characters and a number."
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
