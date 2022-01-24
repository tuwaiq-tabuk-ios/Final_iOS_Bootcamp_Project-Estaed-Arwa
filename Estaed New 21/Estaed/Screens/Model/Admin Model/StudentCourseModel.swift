//
//  StudentCourseModel.swift
//  Estaed
//
//  Created by arwa balawi on 29/05/1443 AH.
//

import Foundation

struct StudentCourseModel
{
  var courseId : String
  var StudentId : String
  var isPaid : Bool
  
  init(courseId :String , stuId:String , isPaid : Bool)
  {
    self.StudentId = stuId
    self.courseId = courseId
    self.isPaid = isPaid
  }
    init()
    {
      self.StudentId = ""
      self.courseId = ""
      self.isPaid = false
    }
  init(value : NSDictionary)
  {
    self.StudentId = value["StudentId"] as! String
    self.courseId = value["courseId"] as! String
    self.isPaid = value["isPaid"] as! Bool
    
  }
  func toDic() -> Any
  {
    return [
      "courseId" : self.courseId,
      "StudentId":self.StudentId,
      "isPaid": self.isPaid
      
    ]  as Any
  }
}

