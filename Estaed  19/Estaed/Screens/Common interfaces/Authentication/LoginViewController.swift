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

  
  @IBOutlet weak var EmailTextField: UITextField!
  @IBOutlet weak var PasswordTextField: UITextField!
  @IBOutlet weak var LoginButton: UIButton!
  @IBOutlet weak var ErrorLabel: UILabel!
  @IBOutlet weak var forgatePassBtn: UIButton!
  @IBOutlet weak var newUserBtn: UIButton!
  var iconClick = false
  let imageicon = UIImageView()

  var user = User()
  
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
  
  //MARK: -Programmatically switch to another interface
  @IBAction func forgatePassword(_ sender: Any) {
    let LoginViewController = self.storyboard?.instantiateViewController(identifier: Constant.storyboard.ForgatePassword)

   self.view.window?.rootViewController = LoginViewController
   self.view.window?.makeKeyAndVisible()
  }
  
  
  //MARK: -Transfer to next textfield directly
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == EmailTextField {
      PasswordTextField.becomeFirstResponder()
    }else {
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
      PasswordTextField.isSecureTextEntry = false
    }
    else
    {
      iconClick = true
      tappedImage.image = UIImage(named: "closeEye")
      PasswordTextField.isSecureTextEntry = true
    }
  }
  
  //MARK: -Programmatically switch to another interface
  @IBAction func haveAccount(_ sender: Any) {
    let LoginViewController = self.storyboard?
      .instantiateViewController(identifier:Constant.storyboard.SignUpViewController)
        
        self.view.window?.rootViewController = LoginViewController
        self.view.window?.makeKeyAndVisible()
  }
  
  
  //MARK: -design label,textField and button By call Utilities class
  func setUpElements() {
    //Too: Hide the error label
  ErrorLabel.alpha = 0
    //Too: Style the element
    Utilities.styleTextField(textfield: EmailTextField)
    Utilities.styleTextField(textfield: PasswordTextField)
    Utilities.styleFilledButton(LoginButton)
    Utilities.styleFilledButton(forgatePassBtn)
    Utilities.styleFilledButton(newUserBtn)
  }
  
  //MARK: -hide the keyboard
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  
//MARK: -Set data from Firbace
  @IBAction func LoginTapped(_ sender: Any) {
    
    //Too: Create cleaned versions of the text field
    let email = EmailTextField.text!
    let password = PasswordTextField.text!
  
    //Too: Signin in the user
    Auth.auth().signIn(withEmail: email , password: password) { result, err in
      
      if err != nil {
        //Too: Couldn't sign in
        self.ErrorLabel.text = err!.localizedDescription
        self.ErrorLabel.alpha = 1
      }
      else {
        //Too: sign in successfully
      print("Finish Auth")
        Database.database().reference().child("users").child(result!.user.uid).getData(){
          error , Data in
          if let data = Data.value as? NSDictionary , Data.exists(){
            print("Found User Data")
            self.user = User(value: data)
            print("user Type : \(self.user.userType)")
            
            if self.user.userType == 0
            {
              // navigate to admin screens
              Constant.userId = result!.user.uid
              if let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ActivateCourseViewController")
                   as? ActivateCourseViewController{
              
               next.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(next, animated: true)
              }
            }else if self.user.userType == 1
            {
              print("we are here ")
              Constant.userId = result!.user.uid
              /// navigate to instructor screen
             if let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Instructors")
                  as? InstructorsCoursesTabelViewController{
             
              next.modalPresentationStyle = .fullScreen
              self.navigationController?.pushViewController(next, animated: true)
             }
            
             
              
            }else
            {
              Constant.StudentId = (result?.user.uid)!
               ////////tabBar Begin
              Constant.navigateToUserScreen(context: self.navigationController!)
            }
          }
        }
        //InstructorsCoursesTabelViewController
//        let homeViewController =
//          self.storyboard?.instantiateViewController(identifier:Constant.storyboard.HomViewController) as? HomViewController
//
//        self.view.window?.rootViewController =  homeViewController
//        self.view.window?.makeKeyAndVisible()
        
        
      }
    }
  }
}

