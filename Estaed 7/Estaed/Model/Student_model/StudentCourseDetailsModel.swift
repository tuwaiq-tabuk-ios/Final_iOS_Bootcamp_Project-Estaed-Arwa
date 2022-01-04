//
//  StudentCourseDetailsModel.swift
//  Estaed
//
//  Created by arwa balawi on 19/05/1443 AH.
//

import Foundation
import UIKit


struct  StudentCourseDetailsModel {
    
  var sCourseContents : String   //Student_Course_Contents
  var sCourseDate : String   // Student_Course_Time
  var sCoursePrice : String // Student_Course_Price
 
    
    func toDic() -> Any
    {
      return [
        "sCourseContents" : self.sCourseContents,
        "sCourseDate": self.sCourseDate,
        "sCoursePrice": self.sCoursePrice,
        ] as Any
  }
    
    
    init(value : NSDictionary)
    {
      self.sCourseContents = value["sCourseContents"] as! String
      self.sCourseDate = value["sCourseDate"] as! String
      self.sCoursePrice = value["sCoursePrice"] as! String
     
    }
    
    
    init(sCourseContents : String,
         sCourseDate : String,
        sCoursePrice : String )
    {
      self.sCourseContents = sCourseContents
      self.sCourseDate = sCourseDate
      self.sCoursePrice = sCoursePrice
      
    }
   
  }








