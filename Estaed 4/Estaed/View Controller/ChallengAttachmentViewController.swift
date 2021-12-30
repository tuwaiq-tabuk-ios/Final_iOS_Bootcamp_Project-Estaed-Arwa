//
//  ChallengAttachmentViewController.swift
//  Estaed
//
//  Created by arwa balawi on 24/05/1443 AH.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseCore

class ChallengAttachmentViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , UITextFieldDelegate {
  /* Qudrat -> Normal ( SelectNumberOfCh : 20 challeng
                       SelectNumberOfWeek : 12 week
                       subjectOfCh : quantitative + verbal
                       difficultyLevel : Easy / Medium / Hard
                       
  */
  @IBOutlet weak var SelectNumberOfWeek: UITextField!
  @IBOutlet weak var SelectNumberOfCh: UITextField!
  @IBOutlet weak var subjectOfCh: UITextField!
  @IBOutlet weak var difficultyLevel: UITextField!
  @IBOutlet weak var titleOfCh: UITextField!
  @IBOutlet weak var addBtn: UIButton!
  @IBOutlet weak var ErrorLabel: UILabel!
  @IBOutlet weak var DisMissButton: UIButton!
  
  
  
  var ref : DatabaseReference!
  let piker = UIPickerView()
    let toolBar = UIToolbar()
  var numOfWeekcurrentIndex = 0 , numOfChcurrentIndex = 0 , subjectcurrentIndex = 0 , diffcurrentIndex = 0
  var numofWeek = false , numOfch = false , subjectch = false , diff = false
  var arrNumberOfCh = ["1) ","2)","3)","4)","5)","6)","7)","8)","9)","10)","11)","12)","13)","14)","15)","16)","17)","18)","19)","20)"]
  
  var arrNumberOfWeek = ["first week","second week","third week","fourth week","fifth week","sixth week","Seventh week","eighth week", "ninth week" ,"tenth week","eleventh week","Twelfth week"]
  
  var arrsubjectOfCh = ["quantitative","verbal"]
  
  var arrdifficultyLevel = ["Easy","Medium","Hard"]
  

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    piker.delegate = self
    piker.dataSource = self
    difficultyLevel.delegate = self
    
    
    toolBar.sizeToFit()
    let btnDone = UIBarButtonItem(title: "Done", style: .plain , target: self , action: #selector(closePicker))
    toolBar.setItems([btnDone], animated: true)
    
      getTextFieldEvent()
//    difficultyLevel.target(forAction: #selector(self.textFieldDidChange(_:)), withSender: )
   
    setUpElements()
    ref = Database.database().reference()
    
  }
  
  @objc func textFieldDidChange(_ textField: UITextField) {
      
      if textField.tag == 100 {
          SelectNumberOfCh.inputView = piker
          SelectNumberOfCh.inputAccessoryView = toolBar
          numOfch = true
          numofWeek = false
          subjectch = false
          diff = false
      }else if textField.tag == 200 {
          SelectNumberOfWeek.inputView = piker
          SelectNumberOfWeek.inputAccessoryView = toolBar
          numOfch = false
          numofWeek = true
          subjectch = false
          diff = false
      }else if textField.tag == 300 {
          subjectOfCh.inputView = piker
          subjectOfCh.inputAccessoryView = toolBar
          numOfch = false
          numofWeek = false
          subjectch = true
          diff = false
      }else if textField.tag == 400 {
          difficultyLevel.inputView = piker
          difficultyLevel.inputAccessoryView = toolBar
          numOfch = false
          numofWeek = false
          subjectch = false
          diff = true
      }
  }
  func setUpElements() {
      ErrorLabel.alpha = 0
      DisMissButton.setTitle("Dismiss", for: .normal)
       DisMissButton.layer.borderWidth = 0
      DisMissButton.tintColor = .white
     DisMissButton.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 1, alpha: 1)
    DisMissButton.setTitleColor(.blue, for: .normal)
    }
  
    func getTextFieldEvent()
    {
        SelectNumberOfCh.tag = 100
        SelectNumberOfCh.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingDidBegin)
        
        SelectNumberOfWeek.tag = 200
        SelectNumberOfWeek.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingDidBegin)
        subjectOfCh.tag = 300
        subjectOfCh.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingDidBegin)
        difficultyLevel.tag = 400
        difficultyLevel.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingDidBegin)
    }
  
  @IBAction func DismissedButtonTapped(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func addBtn(_ sender: Any) {
    // validate
        let error = validateFields()
       if error != nil {
        showError(error!)
       }
      else {
        let ChalId = UUID.init().uuidString
  
        let ChallengAttachment = ChallengAttachmentModel( ChallengAttID : ChalId ,
          numberOfCH: arrNumberOfCh[numOfChcurrentIndex],
          titleOfCH: self.titleOfCh.text!,
          numberOfweek: arrNumberOfWeek[numOfWeekcurrentIndex],
          difficultylevel: arrdifficultyLevel[diffcurrentIndex],
          subjectOfCH: arrsubjectOfCh[subjectcurrentIndex])
        
        
        self.ref.child("courses").child("Qudrat").child("Normal").child("CourseKind").child(ChallengAttachment.ChallengAttID).setValue([
          
          
          "ChallengAttID" : ChallengAttachment.ChallengAttID ,
          "Number Of Week": ChallengAttachment.numberOfweek ,
          "Number Of Challeng":ChallengAttachment.numberOfCH ,
          "subject Of Challeng": ChallengAttachment.subjectOfCH ,
          "difficulty Level": ChallengAttachment.difficultylevel,
          "title Of Challeng": ChallengAttachment.titleOfCH,
          
        ]) {Error, DataRef in
        
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
  
  
  func validateFields() -> String? {
    //Check that all fields are filled in
    if   SelectNumberOfCh.text == "" ||
          SelectNumberOfWeek.text == "" ||
          subjectOfCh.text == "" ||
          difficultyLevel.text == "" ||
          titleOfCh.text == ""
  
   {
    return "please fill in all fields."
  }
     return nil
   }
    
    
    func showError(_ message:String){
      ErrorLabel.text = message
        ErrorLabel.alpha = 1
    
      }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
      if numofWeek
      {
          return arrNumberOfWeek.count
      }else if numOfch
      {
          return arrNumberOfCh.count
      }else if subjectch
      {
          return arrsubjectOfCh.count
      }else
      {
          return arrdifficultyLevel.count
      }
   
  }
  

  
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
  
      if numofWeek
      {
          return arrNumberOfWeek[row]
      }else if numOfch
      {
          return arrNumberOfCh[row]
      }else if subjectch
      {
          return arrsubjectOfCh[row]
      }else
      {
          return arrdifficultyLevel[row]
      }
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      if numofWeek
      {
          SelectNumberOfWeek.text = arrNumberOfWeek[row]
          numOfWeekcurrentIndex = row
      }else if numOfch
      {
          SelectNumberOfCh.text = arrNumberOfCh[row]
          numOfChcurrentIndex = row
      }else if subjectch
      {
          subjectOfCh.text = arrsubjectOfCh[row]
          subjectcurrentIndex = row
      }else
      {
          difficultyLevel.text = arrdifficultyLevel[row]
          diffcurrentIndex = row
      }
   
   
  }
  
  @objc func closePicker() {
 //   SelectNumberOfCh.text = arrNumberOfCh[currentIndex]
    view.endEditing(true)
    
    
  }
  
  
}










/* طريقه انشاء بكير الكترونيا
١)اربط التكست فيلد بالكلاس ثم اعرف متغير وأساويه بكلاس البكير (اوبجكت)
 ٢)احط تو بروتكول ديليقيت و داتا سكور خاصين بالبكير اعلى الكلاس وداخل الفيو لود
 ٣) لدينا تو فنكشن اجباريه اول فنكشن عدد الاعمده وثاني فنكشن عدد الصفوف في العمود حطيت عدد الاعمده واحد والصفوف ابيها ع حسب عدد المعطيات اللي عرفتهم ب الاعلى اللي ابيهم يطلعو بالبكير
 ٤)داخل فيو لود تحت الداتا سكور وقبل اسوي رن لازم احط اسم التكست فيلد.عرض الادخال = الإسم اللي ساويته بكلاس البكير
 ٥) الآن لو اسوي رن بيطلع البكير لكن ع شكل استفهام لذلك احط داله اخرى واسميها titleofrow
 ٦)الآن الارقام ظاهره عندي لكن بسوي داله تطلع لي الرقم اللي موقفه عنده بالتكست فيلد
 ٧) الآن لو افتح بحصل الخيارات تطلع لي بالتكست فيلد طيب ابي اطلع منه خلاص اسوي ديليقيت عشان اوصل للفنكشن الجاهزه
 ٨)بسوي الآن تو بار فوق البكير لذلك بستعين بكلاس ال تول بار اعرف متغير فوق وبداخل الفيو لود وتحت الاسم.الحجم عشان تاخذ الحجم كامل بعدها اعرف متغير واعرفه عشان احدد ديزاين من اسم وعند الاكشن اسوي له داله من نوع اوبجكتف سي تحت سميتها() closePicker
 ٩)عرفت البوتون لكن لسا م ضفته لذلك لازم اضيفه
 ١٠)الآن اسوي رن طلع قائمه الدون بس مافي اكشن عليه عشان م حطيت شي داخل الفنكشن
  
*/
