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
  @IBOutlet weak var answerALabel: UIButton!
  @IBOutlet weak var answerBLabel: UIButton!
  @IBOutlet weak var answerCLabel: UIButton!
  @IBOutlet weak var answerDLabel: UIButton!
  @IBOutlet weak var correctAnswerLabel: UIButton!
  @IBOutlet weak var solutionMethodLabel: UILabel!
  @IBOutlet weak var DisMissButton: UIButton!
  var isBtn1Checked = false ,
      isBtn2Checked = false ,
      isBtn3Checked = false ,
   isBtn4Checked = false,
   isAnswerTrue = false
  
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
     if answerALabel.currentTitle == self.model.correctAnswer
     {
      self.isAnswerTrue = true
      answerALabel.backgroundColor = .systemGreen
     }else
     {
      self.isAnswerTrue = false
      answerALabel.backgroundColor = .systemRed
     }
      
    }
    if isBtn2Checked {
     if answerBLabel.currentTitle == self.model.correctAnswer
     {
      self.isAnswerTrue = true
      answerBLabel.backgroundColor = .systemGreen
     }else
     {
      self.isAnswerTrue = false
      answerBLabel.backgroundColor = .systemRed
     }
      
    }
    if isBtn3Checked {
     if answerCLabel.currentTitle == self.model.correctAnswer
     {
      self.isAnswerTrue = true
      answerCLabel.backgroundColor = .systemGreen
     }else
     {
      self.isAnswerTrue = false
      answerCLabel.backgroundColor = .systemRed
     }
      
    }
    if isBtn4Checked {
     if answerDLabel.currentTitle == self.model.correctAnswer
     {
      self.isAnswerTrue = true
      answerDLabel.backgroundColor = .systemGreen
     }else
     {
      self.isAnswerTrue = false
      answerDLabel.backgroundColor = .systemRed
     }
      
    }
    ref.child("Favorite").child(Constant.StudentId).child(self.ChallingeId).setValue([
      "challingeId" : self.ChallingeId,
      "StudentId" : Constant.StudentId,
      "isCompLeted" : true
    ])
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
    self.ref.child("ChallingeDetails").child(Constant.userId).child(self.ChallingeId).getData { error, Data in
      if let data = Data.value as? NSDictionary , Data.exists(){
        
        self.model  = ChallengDetailsModel(value: data)
        self.quistionOfChallengLabel.text = self.model.quistiontOfCH
        self.answerALabel.setTitle(self.model.answersA, for: .normal)
        self.answerBLabel.setTitle(self.model.answerB, for: .normal)
        self.answerCLabel.setTitle(self.model.answersC, for: .normal)
        self.answerDLabel.setTitle(self.model.answersD, for: .normal)
        self.correctAnswerLabel.setTitle(self.model.correctAnswer, for: .normal)
        self.solutionMethodLabel.text = self.model.solutionMethod
      }
      
  }
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
