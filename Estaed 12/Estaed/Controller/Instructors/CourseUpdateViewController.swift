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
  
  @IBOutlet weak var UCName: UITextField!
  @IBOutlet weak var UCDate: UITextField!
  @IBOutlet weak var UCPrice: UITextField!
  @IBOutlet weak var UCKind: UITextField!
  @IBOutlet weak var UCContents: UITextField!
  @IBOutlet weak var Update: UIButton!
  
  var courseDetails = CourseModel()
  var ref:DatabaseReference!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    UCName.text = courseDetails.courseName
    UCDate.text = courseDetails.courseDate
    UCPrice.text = courseDetails.coursePrice
    UCKind.text = courseDetails.courseTimeKind
    UCContents.text = courseDetails.courseContents
    ref = Database.database().reference()
    
  }
  
  @IBAction func UpdateButoon(_ sender: Any) {

      courseDetails.courseName = UCName.text!
     courseDetails.courseDate = UCDate.text!
    courseDetails.coursePrice =  UCPrice.text!
    courseDetails.courseTimeKind =  UCKind.text!
    courseDetails.courseContents =  UCContents.text!
  

    ref.child("courses").child(Constant.userId).child(courseDetails.courseId).setValue(courseDetails.toDic()){ error , Data in
      
      if error != nil
      {
        print(error?.localizedDescription)
      }
      
      
    }
 

  }


}
