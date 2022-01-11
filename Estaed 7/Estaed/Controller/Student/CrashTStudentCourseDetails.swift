////
////  CrashTStudentCourseDetails.swift
////  Estaed
////
////  Created by arwa balawi on 19/05/1443 AH.
////
//
//import Foundation
//import UIKit
//import FirebaseDatabase
//
//
//class CrashTStudentCourseDetails : UIViewController {
//
//
//  @IBOutlet weak var CourseContentsQStudent: UILabel!
//  @IBOutlet weak var CourseTimeQStudent: UILabel!
//  @IBOutlet weak var CoursePriceQStudent: UILabel!
//
//  var ref : DatabaseReference!
//  var CrshStudentCourseDetailsModellist = [StudentCourseDetailsModel]()
//
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    ref = Database.database().reference()
//    getDetailsOfCourses()
//  }
//
//  func getDetailsOfCourses(){
//
//    ref.child("courses").child("Tahsile").child("Crash").observe(.value) { (snapshot) in
//    let snapshotVaue = snapshot.value as? NSDictionary
//
//
//
//   let CourseContentsStudent = snapshotVaue?["addcoursecontents"] as? String
//   let CoursePriceStudent = snapshotVaue?["addcourseprice"] as? String
//   let CourseTimeStudent = snapshotVaue? ["addcoursetime"] as? String
//   let TeatcherNameStudent = snapshotVaue?["addteachername"] as? String
//
//
//      self.CourseContentsQStudent.text = CourseContentsStudent
//      self.CoursePriceQStudent.text = CoursePriceStudent
//      self.CourseTimeQStudent.text = CourseTimeStudent
//      self.TeatcherNameQStudent.text = TeatcherNameStudent
//
//      self.CrshStudentCourseDetailsModellist.append(StudentCourseDetailsModel(TNS: TeatcherNameStudent!, CCS: CourseContentsStudent!, CTS: CourseTimeStudent!, CPS: CoursePriceStudent!))
//    }
//  }
//
//
//
//  }
//
//
//
//
