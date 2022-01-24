//
//  StudentCourseDetails.swift
//  Estaed
//
//  Created by arwa balawi on 19/05/1443 AH.
//
import Foundation
import UIKit
import FirebaseDatabase


class StudentCourseDetails : UIViewController {
  
  @IBOutlet weak var CourseContentsQStudent: UILabel!
  @IBOutlet weak var CourseTimeQStudent: UILabel!
  @IBOutlet weak var CoursePriceQStudent: UILabel!

  var model = CourseModel()
  var ref : DatabaseReference!
  var CrshStudentCourseDetailsModellist = [StudentCourseDetailsModel]()


  override func viewDidLoad() {
    super.viewDidLoad()
    
      if model != nil
      {
          self.CourseContentsQStudent.text = model.courseContents
          self.CourseTimeQStudent.text = model.courseDate
          self.CoursePriceQStudent.text = model.coursePrice
      }
  }

  
  //MARK: -func Sending the student’s information to the Admin to allow him to enter the course
  @IBAction func btnPay(_ Sender : UIButton)
  {
    let studentCourse = StudentCourseModel(courseId: model.courseId,                                            stuId: Constant.StudentId,
                                            isPaid: false)
    
    let myRef = Database.database().reference().child("StudentCourses")
    myRef.child(Constant.StudentId).child(model.courseId).setValue(studentCourse.toDic()) { error, Data in
      if error == nil
      {
        //MARK: -Programmatically switch to another interface with keep on Navigation Controller bonding
        let story  = UIStoryboard(name: "Main", bundle: nil)
       if let next = story.instantiateViewController(identifier: "payment") as? payment
       {
        next.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(next, animated: true)
        }
      }
      else
      {
        print(error?.localizedDescription)
      }
    }
  }  
}
