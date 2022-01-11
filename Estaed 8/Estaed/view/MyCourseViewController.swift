//
//  MyCourseViewController.swift
//  Estaed
//
//  Created by arwa balawi on 02/06/1443 AH.
//

import UIKit
import FirebaseDatabase

class MyCourseViewController: UIViewController {
  
  @IBOutlet weak var tableViewMyCourse: UITableView!
  
  var ref : DatabaseReference!
  var CourseModelList = [StudentCourseModel]()
  var paidCourses = [StudentCourseModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableViewMyCourse.register(UINib(nibName: "MyCourseCell", bundle: nil), forCellReuseIdentifier: "MyCourseCell")
    tableViewMyCourse.delegate = self
    tableViewMyCourse.dataSource = self
    ref = Database.database().reference()
    
    getdata()
  }
  
  func getdata()
  {
    if !self.CourseModelList.isEmpty
    {
      self.CourseModelList.removeAll()
    }
    self.ref.child("StudentCourses").child(Constant.userId).observe(.value) { dataSnapShot in
      
      if let data =  dataSnapShot.value as? NSDictionary{
        for (_,v) in data {
          let value = v as! NSDictionary
          self.CourseModelList.append(StudentCourseModel(value: value))
        }
        
        for item in self.CourseModelList
        {
          if item.isPaid
          {
            self.paidCourses.append(item)
          }
        }
        self.tableViewMyCourse.reloadData()
      }else
      {
        Constant.getMsg(title: "Error!", Msg: "error while Getting Data", context: self)
      }
     
    }
    
    
  }
}
  
  extension MyCourseViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.CourseModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "MyCourseCell", for: indexPath) as? MyCourseCell
      ref.child("courses").child(Constant.userId).child(self.CourseModelList[indexPath.row].courseId).getData { error, Data in
        if let data = Data.value as? NSDictionary{
          let course = CourseModel(value: data)
          cell!.courseName.text = course.courseName
            
          cell!.courseTimeKind.text = course.courseTimeKind
        }
      }
   
    return cell!
    
  }
  
  
  
}







