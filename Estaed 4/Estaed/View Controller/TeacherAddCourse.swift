//
//  TeacherAddCourse.swift
//  Estaed
//
//  Created by arwa balawi on 10/05/1443 AH.
//
import Foundation
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseCore
class TeacherAddCourse : UIViewController {

    @IBOutlet weak var CoursePrice: UITextField!
    @IBOutlet weak var kindOfCourse: UISwitch!
    @IBOutlet weak var courseTime: UITextField!
    @IBOutlet weak var courseContent: UITextField!
    @IBOutlet weak var teacherName: UITextField! 
    @IBOutlet weak var CourseType: UISwitch!
    @IBOutlet weak var DisMissButton: UIButton!
    @IBOutlet weak var Add: UIButton!
    var ref : DatabaseReference!
  
    @IBAction func DismissedButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
  
    @IBAction func AddButoon(_ sender: Any) {
    // VALIDATION
        var myCourseType : String = ""
        var kindofcourse = ""
        if CourseType.isOn
        {
            myCourseType = "Qudrat"
        }else
        {
            myCourseType = "Tahsile"
        }
        
        if kindOfCourse.isOn
        {
            kindofcourse = "Normal"
        }else
        {
            kindofcourse = "Crash"
        }
        
        let course = CourseDetailsModel(CourseName: myCourseType, addteachername: teacherName.text!, addcoursecontents: courseContent.text!, addcoursetime: courseTime.text!, addcourseprice: CoursePrice.text!, CourseKind: kindofcourse)
    let error = validateFields()
    if error != nil {
        Constant.getMsg(title: "Error!", Msg: "Error In Validating Data", context: self)
    } else {
      //سجل بقاعده البيانات
      
      
        self.ref.child("courses").child(myCourseType).child(kindofcourse).setValue(course.toDic()) { Error, DataRef in
        
        if Error == nil
        {
            Constant.getMsg(title: "Nice Work ", Msg: "Course Added Successfully", context: self){  result, error in
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpElements()
    ref = Database.database().reference()
      
  }
  
  
  func setUpElements() {
     
      DisMissButton.setTitle("Dismiss", for: .normal)
      DisMissButton.layer.borderWidth = 0
      DisMissButton.tintColor = .white
      DisMissButton.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 1, alpha: 1)
      DisMissButton.setTitleColor(.blue, for: .normal)
  }
  
  
  func validateFields() -> String? { // ? لأن تطلع لي رساله لو م حطيتها تقول ان nil غير متوافق مع نوع الارجاع
    //Check that all fields are filled in
    
    if CoursePrice.text! == "" || courseTime.text! == ""  || courseContent.text == "" || teacherName.text == ""
    {
      return "please fill in course name"
    }
    return nil
  }
  
}
