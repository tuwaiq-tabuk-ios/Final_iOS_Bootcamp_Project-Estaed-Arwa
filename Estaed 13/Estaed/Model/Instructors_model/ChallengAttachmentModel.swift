//
//  Challenges.swift
//  Estaed
//
//  Created by arwa balawi on 22/05/1443 AH.
//

import Foundation
import UIKit

struct ChallengAttachmentModel {
  
 var ChallengId : String
 var numberOfCH : String
 var titleOfCH : String
 var numberOfweek : String
 var difficultylevel : String
 var subjectOfCH : String 
  var courseId : String
  
  func toDic() -> Any
  {
    return [
      "ChallengId" : self.ChallengId,
      "numberOfCH":self.numberOfCH,
      "titleOfCH": self.titleOfCH,
      "numberOfweek" : self.numberOfweek,
      "difficultylevel" : self.difficultylevel,
      "subjectOfCH" : self.subjectOfCH,
      "courseId" : self.courseId
    ]  as Any
  }
  init(value : NSDictionary)
  {
    self.ChallengId = value["ChallengId"] as! String
    self.numberOfCH = value["numberOfCH"] as! String
    self.titleOfCH = value["titleOfCH"] as! String
    self.numberOfweek = value["numberOfweek"] as! String
    self.difficultylevel = value["difficultylevel"] as! String
    self.subjectOfCH = value["subjectOfCH"] as! String
    self.courseId = value["courseId"] as! String
  }
  init(ChallengId : String, numberOfCH : String  ,titleOfCH : String ,numberOfweek : String ,difficultylevel : String , subjectOfCH : String ,cId :String)
  {
    self.ChallengId = ChallengId
    self.numberOfCH = numberOfCH
    self.titleOfCH = titleOfCH
    self.numberOfweek = numberOfweek
    self.difficultylevel = difficultylevel
    self.subjectOfCH = subjectOfCH
    self.courseId = cId
  }
 
  
 
}
