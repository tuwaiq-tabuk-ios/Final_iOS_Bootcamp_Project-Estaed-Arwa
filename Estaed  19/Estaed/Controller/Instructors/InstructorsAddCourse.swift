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
    @IBOutlet weak var Add: UIButton!
    var ref : DatabaseReference!
  let datePicker = UIDatePicker()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    setUpElements()
    ref = Database.database().reference()
    createDatePicker()
      
  }
  
  func createDatePicker() {
    
    courseDate.textAlignment = .left
    //toolbar
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    //bar button
    let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
    toolbar.setItems([doneBtn], animated: true)
    
    //assign toolbar
    courseDate.inputAccessoryView = toolbar
    
    //assign date picker to text field
    courseDate.inputView = datePicker
    
    //date picker mode
    datePicker.datePickerMode = .date
    datePicker.frame = .init(x: 10, y: 100, width: view.frame.width, height: 200)
  }
  
  @objc func donePressed(){
    
  // formatter
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    
    courseDate.text = formatter.string(from: datePicker.date)
    self.view.endEditing(true)
    
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
      Constant.getMsg(title:"Error!".localized, Msg: "Error In Validating Data".localized, context: self)
    } else {
      //سجل بقاعده البيانات
      
      
      self.ref.child("courses").child(instructorsId).child(course.courseId).setValue(course.toDic()) { Error, DataRef in
        
        if Error == nil
        {
          Constant.getMsg(title:"Nice Work".localized, Msg:
                            "Course Added Successfully".localized, context: self){  result, error in
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
  

  
  func setUpElements() {
     
//    DisMissButton.setTitle("Dismiss".localized, for: .normal)
//      DisMissButton.layer.borderWidth = 0
//      DisMissButton.tintColor = .white
//      DisMissButton.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 1, alpha: 1)
//      DisMissButton.setTitleColor(.blue, for: .normal)
  }
  
  
  func validateFields() -> String? { // ? لأن تطلع لي رساله لو م حطيتها تقول ان nil غير متوافق مع نوع الارجاع
    //Check that all fields are filled in
    
    if coursePrice.text! == "" || courseDate.text! == ""  || courseContents.text == ""
    {
      return "please fill in all fields.".localized
    }
    return nil
  }
  
}
