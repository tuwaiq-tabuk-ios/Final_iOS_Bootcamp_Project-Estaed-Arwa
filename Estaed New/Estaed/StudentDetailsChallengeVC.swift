//
//  SeeChallengeVC.swift
//  Estaed
//
//  Created by arwa balawi on 26/05/1443 AH.
//


import Foundation
import UIKit
import FirebaseDatabase


class StudentDetailsChallengeVC: UIViewController {
  
  
  @IBOutlet weak var quistionOfChallengLabel: UILabel!
  @IBOutlet weak var answerABtn: UIButton!
  @IBOutlet weak var answerBBtn: UIButton!
  @IBOutlet weak var answerCBtn: UIButton!
  @IBOutlet weak var answerDBtn: UIButton!
  @IBOutlet weak var correctAnswerButton: UIButton!
  @IBOutlet weak var solutionMethodLabel: UILabel!
  @IBOutlet weak var DisMissButton: UIButton!
  var isBtn1Checked = false ,
      isBtn2Checked = false ,
      isBtn3Checked = false ,
   isBtn4Checked = false,
   isAnswerTrue = false
    var modelAttatch = ChallengAttachmentModel()
  var model  = ChallengDetailsModel()
  @IBAction func answerALabel(_ sender: UIButton) {
    isBtn1Checked = true
    isBtn2Checked = false
    isBtn3Checked = false
    isBtn4Checked = false
  }
  
  @IBAction func answerBLabel(_ sender: UIButton) {
    isBtn1Checked = false
    isBtn2Checked = true
    isBtn3Checked = false
    isBtn4Checked = false
  }
  
  
  @IBAction func answerCLabel(_ sender: UIButton) {
    isBtn1Checked = false
    isBtn2Checked = false
    isBtn3Checked = true
    isBtn4Checked = false
  }
  
  
  @IBAction func answerDLabel(_ sender: UIButton) {
    isBtn1Checked = false
    isBtn2Checked = false
    isBtn3Checked = false
    isBtn4Checked = true
  }
  
  
  @IBAction func Cheek(_ sender: Any) {
    
    if isBtn1Checked {
     if answerABtn.currentTitle == self.model.correctAnswer
     {
      self.isAnswerTrue = true
      answerABtn.backgroundColor = .systemGreen
     }else
     {
      self.isAnswerTrue = false
      answerABtn.backgroundColor = .systemRed
     }
      
    }
    if isBtn2Checked {
     if answerBBtn.currentTitle == self.model.correctAnswer
     {
      self.isAnswerTrue = true
      answerBBtn.backgroundColor = .systemGreen
     }else
     {
      self.isAnswerTrue = false
      answerBBtn.backgroundColor = .systemRed
     }
      
    }
    if isBtn3Checked {
     if answerCBtn.currentTitle == self.model.correctAnswer
     {
      self.isAnswerTrue = true
      answerCBtn.backgroundColor = .systemGreen
     }else
     {
      self.isAnswerTrue = false
      answerCBtn.backgroundColor = .systemRed
     }
      
    }
    if isBtn4Checked {
     if answerDBtn.currentTitle == self.model.correctAnswer
     {
      self.isAnswerTrue = true
      answerDBtn.backgroundColor = .systemGreen
     }else
     {
      self.isAnswerTrue = false
      answerDBtn.backgroundColor = .systemRed
     }
      
    }
    ref.child("Favorite").child(K.RealtimeDatabase.studentId).child(self.ChallingeId).setValue([
      "challingeId" : self.ChallingeId,
      "StudentId" : K.RealtimeDatabase.studentId,
      "isCompLeted" : true
    ])
      modelAttatch.isCompLeted = true
    ref.child(K.RealtimeDatabase.challenge).child(modelAttatch.courseId).child(modelAttatch.challengId).setValue(modelAttatch.toDic())
  }
  var ref : DatabaseReference!
  var ChallengDetailsModelList = [ChallengDetailsModel]()
  var ChallingeId = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
      ref = Database.database().reference()
      getChallengDetail()
  //    getData()

    }
  
  
  func getChallengDetail() {
      self.ref.child("ChallingeDetails").child(self.ChallingeId).getData { error, Data in
      if let data = Data.value as? NSDictionary , Data.exists(){
           
                  self.model  = ChallengDetailsModel(value: data)
                  self.quistionOfChallengLabel.text = self.model.quistiontOfCH
                  self.answerABtn.setTitle(self.model.answersA, for: .normal)
                  self.answerBBtn.setTitle(self.model.answerB, for: .normal)
                  self.answerCBtn.setTitle(self.model.answersC, for: .normal)
                  self.answerDBtn.setTitle(self.model.answersD, for: .normal)
             
          
        
      
      }
      
  }
  }

    @IBAction  func showCorrectAnswer(sender : Any)
    {
        self.correctAnswerButton.setTitle(self.model.correctAnswer, for: .normal)
        self.solutionMethodLabel.text = self.model.solutionMethod
        self.isAnswerTrue = false
    }
  func setUpElements() {
    DisMissButton.setTitle("Dismiss".localized, for: .normal)
       DisMissButton.layer.borderWidth = 0
      DisMissButton.tintColor = .white
     DisMissButton.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 1, alpha: 1)
    DisMissButton.setTitleColor(.blue, for: .normal)
    }

}


  
  



//  func getData(){
//    ref.getData { Error, Data in
//      if Error == nil
//      {
//        let data = Data.value as! NSDictionary
//
//          for (_,v) in data  {
//            let v1 = v as! NSDictionary
//            let ChallengDetailsModelList = ChallengDetailsModel (value: v1)
////
//              self.quistionOfChallengLabel.text = ChallengDetailsModelList.quistiontOfCH
//            self.answerALabel.text = ChallengDetailsModelList.answersA
//            self.answerBLabel.text = ChallengDetailsModelList.answerB
//            self.answerCLabel.text = ChallengDetailsModelList.answersC
//            self.answerDLabel.text = ChallengDetailsModelList.answersD
//
//              break
//            }
//
//        }
//      }
//    }
//
