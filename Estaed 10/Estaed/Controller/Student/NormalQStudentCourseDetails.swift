////
////  NormalStudentCourseDetails.swift
////  Estaed
////
////  Created by arwa balawi on 19/05/1443 AH.
////
//
//import Foundation
//import UIKit
//import FirebaseDatabase
//
//class NormalQStudentCourseDetails : UIViewController {
//
//
//
//   @IBOutlet weak var CourseContentsTStudent: UILabel!
//   @IBOutlet weak var CourseTimeTStudent: UILabel!
//   @IBOutlet weak var CoursePriceTStudent: UILabel!
//
//  var ref : DatabaseReference!
//  var NormalStudentCourseDetailsModellist = [StudentCourseDetailsModel]()
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    ref = Database.database().reference()
//    getDetailsOfCourses()
//  }
//
//
//  func getDetailsOfCourses(){
//
//    ref.child("courses").child("Qudrat").child("Normal").observe(.value) { (snapshot) in
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
//      self.CourseContentsTStudent.text = CourseContentsStudent
//      self.CoursePriceTStudent.text = CoursePriceStudent
//      self.CourseTimeTStudent.text = CourseTimeStudent
//
//
//      self.NormalStudentCourseDetailsModellist.append(StudentCourseDetailsModel(TNS: TeatcherNameStudent!, CCS: CourseContentsStudent!, CTS: CourseTimeStudent!, CPS: CoursePriceStudent!))
//    }
//  }
//
//
//}
