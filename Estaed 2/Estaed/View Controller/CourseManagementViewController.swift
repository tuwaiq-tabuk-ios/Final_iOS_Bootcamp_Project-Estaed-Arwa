//
//  CourseManagementViewController.swift
//  Estaed
//
//  Created by arwa balawi on 21/05/1443 AH.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseCore

class CourseManagementViewController: UIViewController {
  
  @IBOutlet weak var DeletButoon: UIButton!
  @IBOutlet weak var UCName: UITextField!
  @IBOutlet weak var UTeacherC: UITextField!
  @IBOutlet weak var UCTime: UITextField!
  @IBOutlet weak var UCPrice: UITextField!
  @IBOutlet weak var UCKind: UITextField!
  @IBOutlet weak var UCContents: UITextField!
  @IBOutlet weak var Update: UIButton!
  
  var courseDetails : CourseDetailsModel!
  var ref:DatabaseReference!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    print("Welocome To Managment Class Teacher Name Is : \(courseDetails.addteachername)")
    ref = Database.database().reference()
    
  }
  
//  
//  @IBAction func DeletButoon(_ sender: Any) {
////
//    ///  to delete button
//    let db = FirebaseDatabase.Database.database()
//
//    if courseDetails.CourseName == "Qudrat" {
//      if courseDetails.CourseKind == "Normal"
//      {
//        ref = db.reference().child("courses").child("Qudrat").child("Normal")
//        ref.removeValue()
//        //end of delete button
//      } else {
//        ref = db.reference().child("courses").child("Qudrat").child("Crash")
//        ref.removeValue()
//      }
//    }
//    else if courseDetails.CourseName == "Tahsile" && courseDetails.CourseKind == "Normal" {
//      ref = db.reference().child("courses").child("Tahsile").child("Normal")
//      ref.removeValue()
//    }else {
//      ref = db.reference().child("courses").child("Tahsile").child("Crash")
//      ref.removeValue()
//
//    }
//  }

  //
//  @IBAction func UpdateButoon(_ sender: Any) {
//    var myCourseType : String = ""
//    var kindofcourse = ""
////    let course = CourseDetailsModel(CourseName: myCourseType, addteachername: teacherName.text!, addcoursecontents: courseContent.text!, addcoursetime: courseTime.text!, addcourseprice: CoursePrice.text!, CourseKind: kindofcourse)
////
//    let course = CourseDetailsModel (CourseName: myCourseType,
//                                     addteachername:self.UTeacherC.text! ,
//                                     addcoursecontents:self.UCContents.text!,
//                                     addcoursetime:self.UCTime.text!,
//                                     addcourseprice:self.UCPrice.text!,
//                                     CourseKind: kindofcourse )
//    //سجل بقاعده البيانات
//    let Id = UUID.init().uuidString
//    self.ref.child("courses").child(myCourseType).child(kindofcourse).setValue(course.toDic())
//
    
//    (["CourseKind": courseDetails.CourseKind ,
//                                                  "CourseName":courseDetails.CourseName ,
//                                                  "addcoursecontents":courseDetails.addcoursecontents ,
//                                                  "addcourseprice":courseDetails.addcourseprice ,
//                                                  "addcoursetime":courseDetails.addcoursetime ,
//                                                  "addteachername":courseDetails.addteachername
//    ])
//
  }


