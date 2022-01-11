//
//  LectureViewController.swift
//  Estaed
//
//  Created by arwa balawi on 29/05/1443 AH.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseCore


class LectureViewController: UIViewController {
  
  
  @IBOutlet weak var LectureName: UITextField!
  @IBOutlet weak var lectureLink: UITextField!
  @IBOutlet weak var ErrorLabel: UILabel!
  @IBOutlet weak var addbtn: UIButton!
  @IBOutlet weak var pickerDate: UIDatePicker!
  
  
  let PickerDate = UIDatePicker()
  let pickerSection = UIPickerView()
  var date = ""
  var time = ""
  var ref : DatabaseReference!
  var LectureModelList = [LectureModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func DateChanged(_ sender: UIDatePicker)
 {
     let getdate = sender.date
     let dateFormatter = DateFormatter()
     
     dateFormatter.dateFormat = "dd-MM-yyyy"
     self.date = dateFormatter.string(from: getdate)
     print(self.date)
     
     let components = Calendar.current.dateComponents([.hour,.minute],
                                                      from: getdate)
     var hour = components.hour!
     var kind = " A.M"
     let minute = components.minute!
     if hour > 12
     {
       hour = hour - 12
       kind = " P.M"
     }
     self.time = String (hour) + " : " + String(minute) + kind
     
     print(self.time)
   }
  
  
  @IBAction func addBtn(_ sender: Any) {
    
    // validate
    let error = validateFields()
    if error != nil {
      showError(error!)
    }
    else {
      let LectId = UUID.init().uuidString
      
      let LectureModelList = LectureModel(LectureName: self.LectureName.text!, lectureURL: self.lectureLink.text! ,lectureTime: self.time, lectureDate: self.date,courseId: LectId )
        ref = Database.database().reference()
        self.ref.child(Constant.lectures).child(LectureModelList.courseId).setValue(LectureModelList.toDic()) {Error, DataRef in
      
        if Error == nil
        {
          Constant.getMsg(title: "Nice Work ", Msg: "lecture Added Successfully", context: self){  result, error in
            if !error
            {
              self.dismiss(animated: true, completion: nil)
              
            }
          }
        }else{
          print(Error.debugDescription)
        }
      }
    }
  }
 
  
  func validateFields() -> String? {
    //Check that all fields are filled in
    if    LectureName.text == "" ||
          lectureLink.text == "" ||
            !date.isEmpty ||
            !time.isEmpty
         
    {
      return "please fill in all fields."
    }
    return nil
  }
  
  
  func showError(_ message:String){
    ErrorLabel.text = message
    ErrorLabel.alpha = 1
    
  }
}
