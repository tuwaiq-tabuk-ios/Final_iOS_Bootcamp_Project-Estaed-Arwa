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
  @IBOutlet weak var answerALabel: UILabel!
  @IBOutlet weak var answerBLabel: UILabel!
  @IBOutlet weak var answerCLabel: UILabel!
  @IBOutlet weak var answerDLabel: UILabel!
  @IBOutlet weak var correctAnswerLabel: UILabel!
  @IBOutlet weak var solutionMethodLabel: UILabel!
  @IBOutlet weak var DisMissButton: UIButton!
  
  @IBAction func Cheek(_ sender: Any) {
    
    
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
      getData()

    }
  
  
  func getChallengDetail() {
    
    ref.child("courses").child("Qudrat").child("Normal")  .child("CourseKind").child("ChallengAttID")
      .observe(.value) { (snapshot) in
        
      let snapshotVaue = snapshot.value as? NSDictionary
        
        let ChallengDetID =
          snapshotVaue?["ChallengDetID"] as? String
        let quistionOfChallengLabel =
          snapshotVaue?["quistion Of Challeng"] as? String
        let answerALabel =
          snapshotVaue?["answer A"] as? String
        let answerBLabel =
          snapshotVaue?["answer B"] as? String
        let answerCLabel =
          snapshotVaue?["answer C"] as? String
        let answerDLabel =
          snapshotVaue?["answer D"] as? String
        let correctAnswerLabel =
          snapshotVaue?["correct Answer"] as? String
        let solutionMethodLabel =
          snapshotVaue?["solution Method"] as? String

        self.quistionOfChallengLabel.text = quistionOfChallengLabel
        self.answerALabel.text = answerALabel
        self.answerBLabel.text = answerBLabel
        self.answerCLabel.text = answerCLabel
        self.answerDLabel.text = answerDLabel
        self.correctAnswerLabel.text = correctAnswerLabel
        self.solutionMethodLabel.text = solutionMethodLabel
        
        
        self.ChallengDetailsModelList.append(ChallengDetailsModel(ChallengDetID:ChallengDetID! , quistiontOfCH: quistionOfChallengLabel!,answersA: answerALabel!, answerB: answerBLabel!, answersC: answerCLabel!, answersD: answerDLabel! , correctAnswer: correctAnswerLabel!, solutionMethod: solutionMethodLabel!, ChallingeId: self.ChallingeId))
    }
      
  }
  
  func getData(){
    ref.getData { Error, Data in
      if Error == nil
      {
        let data = Data.value as! NSDictionary
        
          for (_,v) in data  {
            let v1 = v as! NSDictionary
            let ChallengDetailsModelList = ChallengDetailsModel (value: v1)
//           
              self.quistionOfChallengLabel.text = ChallengDetailsModelList.quistiontOfCH
            self.answerALabel.text = ChallengDetailsModelList.answersA
            self.answerBLabel.text = ChallengDetailsModelList.answerB
            self.answerCLabel.text = ChallengDetailsModelList.answersC
            self.answerDLabel.text = ChallengDetailsModelList.answersD
            
              break
            }
          
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


  
  


