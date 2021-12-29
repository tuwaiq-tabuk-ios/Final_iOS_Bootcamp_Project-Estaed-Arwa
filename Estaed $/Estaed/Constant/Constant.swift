//
//  Constant.swift
//  Estaed
//
//  Created by arwa balawi on 11/05/1443 AH.
//


import UIKit
class Constant
{
  
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
