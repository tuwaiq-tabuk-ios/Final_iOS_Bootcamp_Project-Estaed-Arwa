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
class InstructorsAddCourse : UIViewController {
  

    @IBOutlet weak var coursePrice: UITextField!
    @IBOutlet weak var courseName: UISwitch!
    @IBOutlet weak var courseDate: UITextField!
    @IBOutlet weak var courseContents: UITextField!
    @IBOutlet weak var courseTimeKind: UISwitch!
    @IBOutlet weak var DisMissButton: UIButton!
    @IBOutlet weak var Add: UIButton!
    var ref : DatabaseReference!
  
    @IBAction func DismissedButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
  
    @IBAction func AddButoon(_ sender: Any) {
    // VALIDATION
      let instructorsId = Constant.userId
    
      let pcourseName : String = courseName.isOn ?  Constant.Qudrat : Constant.Tahsely
      let pcourseTimeKind = courseTimeKind.isOn ? Constant.Normal : Constant.Crash
      let course = CourseModel(cId: UUID.init().uuidString,
                               cName: pcourseName,
                               cContent: courseContents.text!, cDate: courseDate.text!, cPrice: coursePrice.text!, cTimeKind: pcourseTimeKind, insId: instructorsId)
    let error = validateFields()
    if error != nil {
        Constant.getMsg(title: "Error!", Msg: "Error In Validating Data", context: self)
    } else {
      //سجل بقاعده البيانات
      
      
      self.ref.child("courses").child(instructorsId).child(course.courseId).setValue(course.toDic()) { Error, DataRef in
        
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
    
    if coursePrice.text! == "" || courseDate.text! == ""  || courseContents.text == ""
    {
      return "please fill in course name"
    }
    return nil
  }
  
}