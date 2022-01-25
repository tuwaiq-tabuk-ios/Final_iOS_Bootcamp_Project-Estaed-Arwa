//
//  LoginViewController.swift
//  EstaedUITests
//
//  Created by arwa balawi on 09/05/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseCore

class LoginViewController: UIViewController,UITextFieldDelegate {

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var forgatePassBtn: UIButton!
  @IBOutlet weak var newUserBtn: UIButton!
  var iconClick = false
  let imageicon = UIImageView()

  var user = User()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    emailTextField.delegate = self
    passwordTextField.delegate = self
    setUpElements()
    
    imageicon.image = UIImage(named: "closeEye")
    
    let contentView = UIView()
    contentView.addSubview(imageicon)
    
    contentView.frame = CGRect(x: 0, y: 0,
                               width: UIImage(named: "closeEye")!.size.width,
                               height: UIImage(named: "closeEye")!.size.height)
    
    imageicon.frame = CGRect(x: -10, y: 0,
                             width: UIImage(named: "closeEye")!.size.width,
                             height: UIImage(named: "closeEye")!.size.height)
   
    passwordTextField.rightView = contentView
    passwordTextField.rightViewMode = .always
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
    
    imageicon.isUserInteractionEnabled = true
    imageicon.addGestureRecognizer(tapGestureRecognizer)
  }
  
  
  //MARK: -Programmatically switch to another interface
  @IBAction func forgatePassword(_ sender: Any) {
    let forgatePassword = self.storyboard?.instantiateViewController(identifier: K.Storyboard.forgatePassword)

   self.view.window?.rootViewController = forgatePassword
   self.view.window?.makeKeyAndVisible()
  }
  
  
  //MARK: -Transfer to next textfield directly
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == emailTextField {
      passwordTextField.becomeFirstResponder()
    }
    else
    {
      //hide the keyboard
      view.endEditing(true)
    }
    return true
  }

  
  //MARK: -action for eyes imge
  @objc func imageTapped (tapGestureRecognizer:UITapGestureRecognizer)
  {
    let tappedImage = tapGestureRecognizer.view as! UIImageView
    
    if iconClick
    {
      iconClick = false
      tappedImage.image = UIImage(named: "openEye")
      passwordTextField.isSecureTextEntry = false
    }
    else
    {
      iconClick = true
      tappedImage.image = UIImage(named: "closeEye")
      passwordTextField.isSecureTextEntry = true
    }
  }
  
  
  //MARK: -Programmatically switch to another interface
  @IBAction func haveAccount(_ sender: Any) {
    
    let signUpViewController = self.storyboard?
      .instantiateViewController(identifier:K.Storyboard.signUpViewController)

        self.view.window?.rootViewController = signUpViewController
        self.view.window?.makeKeyAndVisible()
  }
  
  
  //MARK: -design label,textField and button By call Utilities class
  func setUpElements() {
    //Too: Hide the error label
    errorLabel.isHidden = true
    //Too: Style the element
    Utilities.styleTextField(textfield: emailTextField)
    Utilities.styleTextField(textfield: passwordTextField)
    Utilities.styleFilledButton(loginButton)
    Utilities.styleFilledButton(forgatePassBtn)
    Utilities.styleFilledButton(newUserBtn)
  }
  
  
//MARK: -Set data from Firebace
  @IBAction func loginTapped(_ sender: Any) {
    
    //Too: Create cleaned versions of the text field
    let email = emailTextField.text!
    let password = passwordTextField.text!
  
    //Too: Signin in the user
    Auth.auth().signIn(withEmail: email , password: password) { result, err in
      
      if err != nil {
        //Too: Couldn't sign in
        self.errorLabel.text = err!.localizedDescription
        self.errorLabel.isHidden = false
      }
      else
      {
        //Too: sign in successfully
      print("Finish Auth")
        Database.database().reference().child("users").child(result!.user.uid).getData()
        {
          error , Data in
          if let data = Data.value as? NSDictionary , Data.exists(){
            print("Found User Data")
            self.user = User(value: data)
            print("user Type : \(self.user.userType)")
            
            if self.user.userType == 0
            {
              //Too: navigate to admin screens with keep on Navigation Controller bonding
              K.RealtimeDatabase.userId = result!.user.uid
              if let next = UIStoryboard(name: "Main",
                                         bundle: nil).instantiateViewController(identifier: K.Storyboard.ActivateCourseViewController)
                   as? ActivateCourseViewController{
              
               next.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(next, animated: true)
              }
              
            }else if self.user.userType == 1
            {
              print("we are here ")
              //Too: navigate to instructor screen with keep on Navigation Controller bonding
              K.RealtimeDatabase.userId = result!.user.uid
              
              if let next = UIStoryboard(name: "Main",
                                         bundle: nil).instantiateViewController(identifier: K.Storyboard.InstructorsCoursesTabelViewController)
                  as? InstructorsCoursesTabelViewController{
             
              next.modalPresentationStyle = .fullScreen
              self.navigationController?.pushViewController(next, animated: true)
             }
            
            }else
            {
              //Too: programmatically tabBar (call tabBar func we creat in constant class)
              K.RealtimeDatabase.studentId = (result?.user.uid)!
              K.navigateToUserScreen(context: self.navigationController!)
            }
          }
        }
      }
    }
  }
}

