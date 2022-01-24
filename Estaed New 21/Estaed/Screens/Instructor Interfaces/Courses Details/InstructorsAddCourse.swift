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
   
    ref = Database.database().reference()
    createDatePicker()
  }
  
  
  //MARK: -func to create Date Picker programmatically
  func createDatePicker() {
    courseDate.textAlignment = .left
    //Too: toolbar
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    //Too: bar button
    let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
    toolbar.setItems([doneBtn], animated: true)
    
    //Too: assign toolbar
    courseDate.inputAccessoryView = toolbar
    
    //Too: assign date picker to text field
    courseDate.inputView = datePicker
    
    //Too: date picker mode
    datePicker.datePickerMode = .date
    datePicker.frame = .init(x: 10, y: 100, width: view.frame.width, height: 200)
  }
  
  
  //MARK: -formatter Date Picker
  @objc func donePressed(){
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
  
    courseDate.text = formatter.string(from: datePicker.date)
    self.view.endEditing(true)
  }
  
  
  //MARK: -Transfer to next textfield directly
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == courseContents {
      courseDate.becomeFirstResponder()
      
    }else if  textField == courseDate {
      coursePrice.becomeFirstResponder()
    }
    else
    {
      //MARK: -hide the keyboard
      view.endEditing(true)
    }
    return true
  }
  
  
  //MARK: -Register in the database
    @IBAction func AddButoon(_ sender: Any) {
      
      let instructorsId = Constant.userId
      let pcourseName : String = courseName.isOn ?  Constant.Qudrat : Constant.Tahsely
      
      let pcourseTimeKind = courseTimeKind.isOn ? Constant.Normal : Constant.Crash
      
      let course = CourseModel(cId: UUID.init().uuidString,
                               cName: pcourseName,
                               cContent: courseContents.text!, cDate: courseDate.text!,
                                 cPrice: coursePrice.text!,  cTimeKind: pcourseTimeKind,    insId: instructorsId)
    let error = validateFields()
    if error != nil {
      
      //Too: If it is empty
      Constant.getMsg(title:"Error!".localized,
                      Msg: "Error In Validating Data".localized,
                      context: self)
    }
    else
    {
      
    //Too: Register in the database
      self.ref.child("courses").child(instructorsId).child(course.courseId).setValue(course.toDic()) { Error, DataRef in
        
        if Error == nil
        {
          //Too: If it is not empty
          Constant.getMsg(title:"Nice Work".localized,
                          Msg:"Course Added Successfully".localized,
                             context: self)
          {  result, error in
                if !error
                {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        else
        {
          print(Error.debugDescription)
        }
      }
    }
  }
  
  
  //MARK: -Check that all fields are filled in
  func validateFields() -> String? {
    if coursePrice.text! == "" ||
        courseDate.text! == ""  ||
        courseContents.text == ""
    {
      return "please fill in all fields.".localized
    }
    return nil
  }
}
