//
//  File.swift
//  Estaed
//
//  Created by arwa balawi on 10/05/1443 AH.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseCore

class TeacherCourseDetails : UIViewController{}
//
//  @IBOutlet weak var addCourseName: UITextField!
//  @IBOutlet weak var addTeatcherName:
//    UITextField!
//  @IBOutlet weak var addCoursContents:
//    UITextField!
//  @IBOutlet weak var addCoursTime: UITextField!
//  @IBOutlet weak var addCoursePrice: UITextField!
//  @IBOutlet weak var addButton: UIButton!
//  @IBOutlet weak var ErrorLabel: UILabel!
//  var ref : DatabaseReference!
//
////MARK:- كيفيه إضافه زر ال Dismiss 1
////أسحبه كمتغير عشان لو بصممه و كفنكشن
//  @IBOutlet weak var DisMissButton: UIButton!
//  //مابداخله بيطلع تلقائي نظرا لكلاس ال
//  @IBAction func DismissedButtonTapped(_ sender: Any) {
//      self.dismiss(animated: true, completion: nil)
//
//  }
//
//
//
//
//  @IBAction func addButtonTapped(_ sender: Any) {
//    // validate
//    let error = validateFields()
//    if error != nil {
//    showError(error!)
//    }
//    else {
//
//      let coursedetails = CourseDetails(
//        addcoursename: self.addCourseName.text!,
//        addteachername: self.addTeatcherName.text!,
//        addcoursecontents: self.addCoursContents.text!,
//        addcoursetime: self.addCoursTime.text!,
//        addcourseprice: self.addCoursePrice.text!)
//
//
//      let Id = UUID.init().uuidString
//      self.ref.child("course details").child(Id).setValue([
//        "add course name": coursedetails.addcoursename,
//        "add teacher name": coursedetails.addteachername,
//        "add course contents": coursedetails.addcoursecontents,
//        "add course time": coursedetails.addcoursetime,
//        "add course price": coursedetails.addcourseprice
//        ])
//      {Error, DataRef in
//
//      if Error == nil
//      {          //
//        Constant.getMsg(title: "Nice Work ", Msg: "Course Added Successfully", context: self){  result, error in
//            if !error
//            {
//                self.dismiss(animated: true, completion: nil)
//
//            }
//        }
//      }else{
//        print(Error.debugDescription)
//    }
//   }
//  }
// }
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    setUpElements()
//    ref = Database.database().reference()
//  }
//
//
//  func showError(_ message:String){
//    ErrorLabel.text = message
//    ErrorLabel.alpha = 1
//
//  }
//
//
//  func setUpElements() {
//    ErrorLabel.alpha = 0
//    DisMissButton.setTitle("Dismiss", for: .normal)
//     DisMissButton.layer.borderWidth = 0
//    DisMissButton.tintColor = .white
//    DisMissButton.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 1, alpha: 1)
//   DisMissButton.setTitleColor(.blue, for: .normal)
//  }
//
//
//  func validateFields() -> String? {
//    //Check that all fields are filled in
//    if  addCourseName.text == "" ||
//        addTeatcherName.text == "" ||
//        addCoursContents.text == "" ||
//          addCoursTime.text == "" ||
//        addCoursePrice.text == ""
//
//    {
//  return "please fill in all fields."
//}
//    return nil
//  }
//
//
//}
