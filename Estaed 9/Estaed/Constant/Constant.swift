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
        let Dismiss = UIAlertAction(title: "Dismiss", style: .cancel) {  DismissAction in
            
            print("Dismiss Done")
          
        }
       
        alert.addAction(Dismiss)
      
        context.present(alert, animated: true) {
           
            print("Alert Start")
        }
    }
  
  
    
    typealias handler = (_ result : String,_ error :Bool)-> Void
        
        static func getMsg(title : String , Msg : String,context : UIViewController ,callBack:@escaping handler)
        {
            var action = ""
            let alert = UIAlertController(title: title, message: Msg, preferredStyle: .alert)
            let Dismiss = UIAlertAction(title: "Dismiss", style: .cancel) {  DismissAction in
                
                action = "Dismiss"
                print(action)
                callBack(action,false)
            }
           
            alert.addAction(Dismiss)
          
            
            context.present(alert, animated: true) {
               
                print("Alert Start")
            }
        }
}
