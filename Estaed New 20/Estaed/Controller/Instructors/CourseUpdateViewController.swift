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

class CourseUpdateViewController: UIViewController {
  
  @IBOutlet weak var updateCourseName: UITextField!
  @IBOutlet weak var updateCourseDate: UITextField!
  @IBOutlet weak var updateCoursePrice: UITextField!
  @IBOutlet weak var updateCourseKind: UITextField!
  @IBOutlet weak var updateCourseContents: UITextField!
  @IBOutlet weak var Update: UIButton!
  
  var courseDetails = CourseModel()
  var ref:DatabaseReference!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateCourseName.text = courseDetails.courseName
    updateCourseDate.text = courseDetails.courseDate
    updateCoursePrice.text = courseDetails.coursePrice
    updateCourseKind.text = courseDetails.courseTimeKind
    updateCourseContents.text = courseDetails.courseContents
    ref = Database.database().reference()
  }
  
  //MARK: -func to make update in Firebase
  @IBAction func UpdateButoon(_ sender: Any) {
    
      courseDetails.courseName = updateCourseName.text!
     courseDetails.courseDate = updateCourseDate.text!
    courseDetails.coursePrice =  updateCoursePrice.text!
    courseDetails.courseTimeKind =  updateCourseKind.text!
    courseDetails.courseContents =  updateCourseContents.text!
  
    ref.child("courses").child(Constant.userId).child(courseDetails  .courseId).setValue(courseDetails.toDic()){ error , Data in
      
      if error != nil
      {
        print(error?.localizedDescription)
      }
      Constant.getMsg(title:"Nice Work".localized,
                      Msg:"Course Update Successfully".localized,
                      context: self)
    }
  }
//
  //MARK: - func to hidethe keyboard
  @IBAction func dismisskKeyboard(_ sender: UITapGestureRecognizer) {
    updateCourseName.resignFirstResponder()
    updateCourseKind.resignFirstResponder()
    updateCourseContents.resignFirstResponder()
    updateCourseDate.resignFirstResponder()
    updateCoursePrice.resignFirstResponder()
  }
  
}
