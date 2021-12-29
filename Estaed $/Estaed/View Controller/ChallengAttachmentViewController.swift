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
  
  
  var ref : DatabaseReference!
  let piker = UIPickerView()
  
  var arrNumberOfCh = ["1) ","2)","3)","4)","5)","6)","7)","8)","9)","10)","11)","12)","13)","14)","15)","16)","17)","18)","19)","20)"]
  
  var arrNumberOfWeek = ["first week","second week","third week","fourth week","fifth week","sixth week","Seventh week","eighth week", "ninth week" ,"tenth week","eleventh week","Twelfth week"]
  
  var currentIndex = 0
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    piker.delegate = self
    piker.dataSource = self
    
    
    let toolBar = UIToolbar()
    toolBar.sizeToFit()
    let btnDone = UIBarButtonItem(title: "Done", style: .plain , target: self , action: #selector(closePicker))
    toolBar.setItems([btnDone], animated: true)
    
    SelectNumberOfCh.inputView = piker
    SelectNumberOfCh.inputAccessoryView = toolBar
    
    
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
  
        let ChallengAttachmentModelList  = ChallengAttachmentModel(
          numberOfCH: self.SelectNumberOfCh.text!,
          titleOfCH: self.titleOfCh.text!,
          numberOfweek: self.SelectNumberOfWeek.text!,
          difficultylevel: self.difficultyLevel.text!,
          subjectOfCH: self.subjectOfCh.text!)
        
        let Id = UUID.init().uuidString
        self.ref.child("courses").child("Qudrat").child("Normal").setValue([
          "Number Of Week": ChallengAttachmentModelList.numberOfweek ,
          "Number Of Challeng": ChallengAttachmentModelList.numberOfCH ,
          "subject Of Challeng": ChallengAttachmentModelList.subjectOfCH ,
          "difficulty Level": ChallengAttachmentModelList.difficultylevel,
          "title Of Challeng": ChallengAttachmentModelList.titleOfCH,
          
        ])
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//       let coursedetails =
        
//          addcoursename: self.addCourseName.text!,
//          addteachername: self.addTeatcherName.text!,
//          addcoursecontents: self.addCoursContents.text!,
//          addcoursetime: self.addCoursTime.text!,
//          addcourseprice: self.addCoursePrice.text!)
//
    
    
    
    
    
    // addcoursename: self.addCourseName.text!,
    
    
    
    
    
    
    
    
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
    return arrNumberOfCh.count
  }
  
//  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//    return arrNumberOfWeek.count
//  }
  
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
    return arrNumberOfCh[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    currentIndex = row
    SelectNumberOfCh.text = arrNumberOfCh[row]
  }
  
  @objc func closePicker() {
    SelectNumberOfCh.text = arrNumberOfCh[currentIndex]
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
