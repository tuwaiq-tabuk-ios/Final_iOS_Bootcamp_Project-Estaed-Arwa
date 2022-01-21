//
//  ProfileStudent.swift
//  Estaed
//
//  Created by arwa balawi on 21/05/1443 AH.
//


import UIKit
import Firebase

class ProfileStudentViewController : UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var languageSegmentControl: UISegmentedControl! {
   didSet
     {
     if let lang = UserDefaults.standard.string(forKey: "currentLanguage"){
       switch lang {
       case "ar":
         languageSegmentControl.selectedSegmentIndex = 0
         UIView.appearance().semanticContentAttribute = .forceLeftToRight
       case "en":
         languageSegmentControl.selectedSegmentIndex = 1
         UIView.appearance().semanticContentAttribute = .forceLeftToRight
       default:
         let localLang = Locale.current.languageCode
         if localLang == "en"{
           languageSegmentControl.selectedSegmentIndex = 1
         }else {
           languageSegmentControl.selectedSegmentIndex = 0
         }
       }
     }else {
       let localLang = Locale.current.languageCode
       UserDefaults.standard.setValue([localLang], forKey: "AppleLanguage")
       if localLang == "en" {
         languageSegmentControl.selectedSegmentIndex = 0
       }else{
         languageSegmentControl.selectedSegmentIndex = 1
         }
       }
     }
  }
  
  @IBAction func languageSegmentControl(_ sender: UISegmentedControl) {
    if let lang = sender.titleForSegment(at: sender.selectedSegmentIndex)?.lowercased(){
      UserDefaults.standard.setValue(lang, forKey: "currentLanguage")
      Bundle.setLanguage(lang)
      let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
      if let windowScane = UIApplication.shared.connectedScenes.first as? UIWindowScene,
         let sceneDelegate = windowScane.delegate as? SceneDelegate {
        sceneDelegate.window?.rootViewController =
        storyboard.instantiateInitialViewController()

    }
  }
}
  
  
  
  @IBAction func logOutButtonTapped(_ sender: Any) {
    try? Auth.auth().signOut()
    
    let homeViewcontroller = self.storyboard? .instantiateViewController(identifier: Constant.storyboard.LoginViewController)
    
    self.view.window?.rootViewController = homeViewcontroller
    self.view.window?.makeKeyAndVisible()
    
   
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // To make Circle Image
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = imageView.frame.height / 2
  }
  
}
