//
//  ChallengDetailsViewController.swift
//  Estaed
//
//  Created by arwa balawi on 24/05/1443 AH.
//
import Foundation
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseCore

class ChallengDetailsViewController: UIViewController {
  
  @IBOutlet weak var quistionOfChalleng: UITextField!
  @IBOutlet weak var answerA: UITextField!
  @IBOutlet weak var answerB: UITextField!
  @IBOutlet weak var answerC: UITextField!
  @IBOutlet weak var answerD: UITextField!
  @IBOutlet weak var correctAnswer: UITextField!
  @IBOutlet weak var solutionMethod: UITextField!
  @IBOutlet weak var doneBtn: UIButton!

  @IBOutlet weak var ErrorLabel: UILabel!
  
  var ref : DatabaseReference!
  var TransferedCId = ""
  var ChallingeId = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
      ref = Database.database().reference()
  }
  
  
  func setUpElements() {
      ErrorLabel.alpha = 0
//      DisMissButton.setTitle("Dismiss", for: .normal)
//       DisMissButton.layer.borderWidth = 0
//      DisMissButton.tintColor = .white
//     DisMissButton.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 1, alpha: 1)
//    DisMissButton.setTitleColor(.blue, for: .normal)
    }
  
  
//  @IBAction func DismissedButtonTapped(_ sender: Any) {
//      self.dismiss(animated: true, completion: nil)
//  }
  //ChallengDetailsModel
  @IBAction func DoneBtn(_ sender: Any) {
    // validate
        let error = validateFields()
       if error != nil {
        showError(error!)
       }
      else {
        let ChalDId = UUID.init().uuidString
  
        let ChallengDetailsModelList =
          ChallengDetailsModel(ChallengDetID:
                                ChalDId,
                               quistiontOfCH:  self.quistionOfChalleng.text!,
                               answersA: self.answerA.text!, answerB: self.answerB.text!, answersC: self.answerC.text!, answersD: self.answerD.text!, correctAnswer: self.correctAnswer.text!, solutionMethod: self.solutionMethod.text!,ChallingeId : self.ChallingeId)
          
          
        
        self.ref.child("ChallingeDetails").child(Constant.userId).child(self.ChallingeId)  .child(ChallengDetailsModelList.ChallengDetID).setValue(ChallengDetailsModelList.toDic()) {Error, DataRef in
        
             if Error == nil
              {
              Constant.getMsg(title:"Nice Work".localized, Msg: "Course Added Successfully".localized, context: self){  result, error in
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
    if  quistionOfChalleng.text == "" ||
          answerA.text == "" ||
          answerB.text == "" ||
          answerC.text == "" ||
          answerD.text == "" ||
          correctAnswer.text == "" ||
          solutionMethod.text == ""
          
   {
      return "please fill in all fields.".localized
  }
     return nil
   }
  
  func showError(_ message:String){
    ErrorLabel.text = message
      ErrorLabel.alpha = 1
  
    }
  
  
}
