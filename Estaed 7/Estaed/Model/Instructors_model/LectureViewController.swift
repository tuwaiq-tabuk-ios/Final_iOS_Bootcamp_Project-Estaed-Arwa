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
  
  
  @IBOutlet weak var lectureLink: UITextField!
  @IBOutlet weak var lectureDate: UITextField!
  @IBOutlet weak var lecctureTime: UITextField!
  @IBOutlet weak var ErrorLabel: UILabel!
  @IBOutlet weak var addbtn: UIButton!
  
  var ref : DatabaseReference!
  var LectureModelList = [LectureModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func addBtn(_ sender: Any) {
    
    // validate
    let error = validateFields()
    if error != nil {
      showError(error!)
    }
    else {
      let LectId = UUID.init().uuidString
      
      
      let LectureModelList = LectureModel(lectureURL: self.lectureLink.text!, lectureTime: self.lecctureTime.text!, lectureDate: self.lectureDate.text!, courseId: LectId)
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
  
  ///  function Add
  ///  let lecture = LectureModel()
  ////  ref.child("CourseLectures").child(courseId).setValue(lecture.toDic()){
  
  ///}
  
  func validateFields() -> String? {
    //Check that all fields are filled in
    if   lectureLink.text == "" ||
          lectureDate.text == "" ||
          lecctureTime.text == ""
         
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
