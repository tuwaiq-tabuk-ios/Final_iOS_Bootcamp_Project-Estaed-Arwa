//
//  Constant.swift
//  Estaed
//
//  Created by arwa balawi on 11/05/1443 AH.
//


import UIKit
class Constant
{
  
  
  static var Crash = "Crash"
  static var Normal = "Normal"
  static var Tahsely =  "Tahsely"
  static var Qudrat = "Qudrat"
  static var userId = "asdasdasdasd"
  static var StudentId = "1001"
  static var courseId = ""
  static var courses = "courses"
  static var challenge = "challenge"
  static var lectures = "Lectures"
  static var courseName = ""
  static var courseTimeKind = ""

    static func getMsg(title : String , Msg : String,context : UIViewController )
    {
       
        let alert = UIAlertController(title: title, message: Msg, preferredStyle: .alert)
      let Dismiss = UIAlertAction(title: "Dismiss".localized, style: .cancel) {  DismissAction in
            
        print("Dismiss Done".localized)
          
        }
       
        alert.addAction(Dismiss)
      
        context.present(alert, animated: true) {
           
          print("Alert Start".localized)
        }
    }
  
  
    
    typealias handler = (_ result : String,_ error :Bool)-> Void
        
        static func getMsg(title : String , Msg : String,context : UIViewController ,callBack:@escaping handler)
        {
            var action = ""
            let alert = UIAlertController(title: title, message: Msg, preferredStyle: .alert)
          let Dismiss = UIAlertAction(title: "Dismiss".localized, style: .cancel) {  DismissAction in
                
                action = "Dismiss"
                print(action)
                callBack(action,false)
            }
           
            alert.addAction(Dismiss)
          
            
            context.present(alert, animated: true) {
               
              print("Alert Start".localized)
            }
        }
  
  
  struct storyboard {
    
  static let SignUpViewController = "SignUp"
  static let LoginViewController = "LogIn"
  static let CourseUpdateViewController = "courseManage"
  static let LectureTableViewController = "LectureTableViewController"
  static let ChallengesTableViewController = "Challenges"
  static let HomViewController = "HomViewController"
  static let StudentTimeKindViewController = "StudentTimeKindViewController"
  static let StudentChallengAttachmentVC = "StudentChallengAttachmentVC"
  static let StudentCourseDetails = "StudentCourseDetails"
  static let myLecture = "myLectureViewController"
  static let MyLectureCell = "MyLectureCell"
  static let ForgatePassword = "ForgatePasswordViewController"
  static let StudentDetailsChallengeVC = "StudentDetailsChallengeVC"
    
  }
  
}

extension String {
  var localized : String {
  return NSLocalizedString(self,tableName: "Localizable",comment: self)
}
  //func localized() -> String {
  //return NSLocalizedString(
  // self,
  // tableName: "Localizable",
  // bundle: .main,
  // value: self,
  // comment: self
  //)
  
  //for seguy
  func localizableString(loc: String) -> String{
    let path = Bundle.main.path(forResource: loc, ofType: "lproj")
    let bundle = Bundle(path: path!)
    return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    
  }

}


