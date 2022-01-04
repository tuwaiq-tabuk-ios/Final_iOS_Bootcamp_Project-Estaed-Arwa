//
//  TeacherCourses.swift
//  Estaed
//
//  Created by arwa balawi on 10/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class InstructorsCoursesTabelViewController : UIViewController {
  
  @IBOutlet var tableViewCD : UITableView!
  var courses = [CourseModel]()  /// ???? ()
  var ref: DatabaseReference!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableViewCD.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    tableViewCD.delegate = self
    tableViewCD.dataSource = self
    ref = Database.database().reference().child("courses").child(Constant.userId)
    getCourses()
  }
  
  
  func getCourses()
  {
    
    self.ref.observe(.value) { dataSnapShot in
      if !self.courses.isEmpty
      {
        self.courses.removeAll()
      }
      if let data =  dataSnapShot.value as? NSDictionary{
        for (_,v) in data {
          let value = v as! NSDictionary
          self.courses.append(CourseModel(value: value))
        }
             
        
      }else
      {
        Constant.getMsg(title: "Error!", Msg: "error while Getting Data", context: self)
        
      }
      self.tableViewCD.reloadData()
    }
  }
  
 
  
}

extension InstructorsCoursesTabelViewController : UITableViewDelegate,UITableViewDataSource ,MyCellDelegate
{
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
    cell?.courseName.text = self.courses[indexPath.row].courseName
    cell?.courseTimeKind.text = self.courses[indexPath.row].courseTimeKind
    cell?.courseContents.text = self.courses[indexPath.row].courseContents
    cell?.coursePrice.text = self.courses[indexPath.row].coursePrice
    cell?.courseTime.text = self.courses[indexPath.row].courseDate
    cell?.btnManageCourse.tag = indexPath.row
    cell?.btnChallenge.tag = indexPath.row
    cell?.myCellDelegate = self
 
    return cell!
  }
  
  
  func didPressButton(_ tag : Int)
  {
    let courseDetails = self.courses[tag]
   
    //تأكدت ان المعلومات انتقلت الآن الى هذه الواجهه
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    let Manage = storyboard?.instantiateViewController(identifier: "courseManage") as? CourseUpdateViewController
    Manage?.courseDetails = courseDetails
    //تم انتقال المعلومات
    Constant.courseName = courseDetails.courseName
    Constant.courseTimeKind = courseDetails.courseTimeKind
    let Challenge = storyboard?.instantiateViewController(identifier: "Challenges") as? ChallengesTableViewController
    Challenge?.TransferedCId = courseDetails.courseId
    Challenge?.modalPresentationStyle = .fullScreen
    self.present(Challenge!, animated: true, completion: nil)
    //    //تم انتقال المعلومات
  }

  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return self.courses.count // عدد صفوف
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1  // قسم واحد
  }
}
