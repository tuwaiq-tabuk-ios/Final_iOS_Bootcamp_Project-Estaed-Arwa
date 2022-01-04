//
//  StudentCourseDetailsModel.swift
//  Estaed
//
//  Created by arwa balawi on 19/05/1443 AH.
//

import Foundation
import UIKit


struct  LectureModel {
    
  var lectureURL : String
  var lectureTime : String
  var lectureDate : String
  var courseId : String
    
    func toDic() -> Any
    {
      return [
        "lectureURL" : self.lectureURL,
        "lectureTime": self.lectureTime,
        "lectureDate": self.lectureDate,
        "courseId" : self.courseId
        ] as Any
  }
    
    
    init(value : NSDictionary)
    {
      self.lectureURL = value["lectureURL"] as! String
      self.lectureTime = value["lectureTime"] as! String
      self.lectureDate = value["lectureDate"] as! String
      self.courseId = value["courseId"] as! String
     
    }
    
    
    init(lectureURL : String,
         lectureTime : String,
         lectureDate : String,
         courseId : String)
    {
      self.lectureURL = lectureURL
      self.lectureTime = lectureTime
      self.lectureDate = lectureDate
      self.courseId = courseId
      
    }
   
  }









