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
  
  @IBOutlet weak var courseContentsQStudent: UILabel!
  @IBOutlet weak var courseTimeQStudent: UILabel!
  @IBOutlet weak var coursePriceQStudent: UILabel!

  var model : CourseModel!
  var ref : DatabaseReference!
  var crshStudentCourseDetailsModellist = [StudentCourseDetailsModel]()


  override func viewDidLoad() {
    super.viewDidLoad()
    
      if model != nil
      {
          self.courseContentsQStudent.text = model.courseContents
          self.courseTimeQStudent.text = model.courseDate
          self.coursePriceQStudent.text = model.coursePrice
      }
  }

  
  //MARK: -func Sending the student’s information to the Admin to allow him to enter the course
  @IBAction func btnPay(_ Sender : UIButton)
  {
    let studentCourse = StudentCourseModel(courseId: model.courseId,                                                                 stuId: K.RealtimeDatabase.studentId,
                                            isPaid: false)
    
    let myRef = Database.database().reference().child("StudentCourses")
    myRef.child(K.RealtimeDatabase.studentId).child(model.courseId).setValue(studentCourse.toDic()) { error, Data in
      if error == nil
      {
        
        //MARK: -Programmatically switch to another interface with keep on Navigation Controller bonding
        let story  = UIStoryboard(name: "Main",
                                  bundle: nil)
        if let next = story.instantiateViewController(identifier: K.Storyboard.payment) as? Payment
       {
        next.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(next, animated: true)
        }
      }
      else
      {
        print(error?.localizedDescription as Any)
      }
    }
  }  
}
