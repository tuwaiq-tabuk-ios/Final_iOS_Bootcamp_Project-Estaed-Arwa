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

  var ref : DatabaseReference!
  var CrshStudentCourseDetailsModellist = [StudentCourseDetailsModel]()


  override func viewDidLoad() {
    super.viewDidLoad()

    ref = Database.database().reference().child("courses").child(Constant.userId)
    getDetailsOfCourses()
  }

  @IBAction func btnPay(_ Sender : UIButton)
  {
    let studentCourse = StudentCourseModel(courseId: Constant.courseId, stuId: Constant.StudentId, isPaid: false)
    let myRef = Database.database().reference().child("StudentCourses")

    myRef.child(Constant.StudentId).setValue(studentCourse.toDic()) { error, Data in
      if error == nil
      {
        let story  = UIStoryboard(name: "Main", bundle: nil)
       if let next = story.instantiateViewController(identifier: "payment") as? payment{
        next.modalPresentationStyle = .fullScreen
        self.present(next, animated: true, completion: nil)
        }
      }else
      {
        print(error?.localizedDescription)
      }
    }
  }

  func getDetailsOfCourses(){
    ref.getData { Error, Data in
      if Error == nil
      {
        let data = Data.value as! NSDictionary
        
          for (_,v) in data  {
            let v1 = v as! NSDictionary
            let course = CourseModel(value: v1)
            if course.courseName == Constant.courseName &&
                course.courseTimeKind == Constant.courseTimeKind{
              Constant.courseId = course.courseId
              self.CourseContentsQStudent.text = course.courseContents
              self.CourseTimeQStudent.text = course.courseDate
              self.CoursePriceQStudent.text = course.coursePrice
              break
            }
          
        }
      }
    }

  
  }


  }
