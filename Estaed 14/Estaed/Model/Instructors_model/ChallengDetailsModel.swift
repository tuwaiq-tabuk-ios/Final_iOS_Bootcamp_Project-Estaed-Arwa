//
//  m.swift
//  Estaed
//
//  Created by arwa balawi on 24/05/1443 AH.
//

import Foundation
import UIKit

struct ChallengDetailsModel {
  
var ChallengDetID : String
var quistiontOfCH : String
var answersA : String
var answerB : String
var answersC : String
var answersD : String
var correctAnswer : String
var solutionMethod : String
  var ChallingeId : String
  
  func toDic() -> Any
  {
    return [
      "ChallengDetID" : self.ChallengDetID,
      "quistiontOfCH": self.quistiontOfCH,
      "answersA": self.answersA,
      "answerB":self.answerB,
      "answersC":self.answersC,
      "answersD":self.answersD,
      "correctAnswer":self.correctAnswer,
      "solutionMethod":self.solutionMethod,
      "ChallingeId":self.ChallingeId
      
      ] as Any
}
  
  
  init(value : NSDictionary)
  {
    self.ChallengDetID = value["ChallengDetID"] as! String
    self.quistiontOfCH = value["quistiontOfCH"] as! String
    self.answersA = value["answersA"] as! String
    self.answerB = value["answerB"] as! String
    self.answersC = value["answersC"] as! String
    self.answersD = value["answersD"] as! String
    self.correctAnswer = value["correctAnswer"] as! String
    self.solutionMethod = value["solutionMethod"] as! String
    self.ChallingeId = value["ChallingeId"] as! String
  }
  
  
  init(ChallengDetID : String, quistiontOfCH : String  ,answersA : String ,answerB : String ,answersC : String , answersD : String ,correctAnswer :String , solutionMethod :String,ChallingeId :String)
  {
    self.ChallengDetID = ChallengDetID
    self.quistiontOfCH = quistiontOfCH
    self.answersA = answersA
    self.answerB = answerB
    self.answersC = answersC
    self.answersD = answersD
    self.correctAnswer = correctAnswer
    self.solutionMethod = solutionMethod
    self.ChallingeId = ChallingeId
  }
 
}


