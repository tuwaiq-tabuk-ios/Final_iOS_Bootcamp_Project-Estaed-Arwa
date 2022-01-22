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
  var courses = [CourseModel]()
  var ref: DatabaseReference!
  var currentCourseindex = -1
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Too: hide back button come frome previous interface
    navigationItem.hidesBackButton = true
    
    tableViewCD.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    
    tableViewCD.delegate = self
    tableViewCD.dataSource = self
    ref = Database.database().reference().child("courses").child(Constant.userId)
    getCourses()
  }
  
  //MARK: -get Courses
  func getCourses()
  {
    self.ref.observe(.value) { dataSnapShot in
      if !self.courses.isEmpty
      {
        self.courses.removeAll()
      }
      if let data =  dataSnapShot.value as? NSDictionary, dataSnapShot.exists(){
        for (_,v) in data {
          let value = v as! NSDictionary
          self.courses.append(CourseModel(value: value))
        }
        self.tableViewCD.reloadData()
      }
    }
  }
  
  //MARK: -Programmatically switch to another interface with keep on Navigation Controller bonding
  @IBAction func AddBtn(_ sender: Any) {
    if let next = storyboard?.instantiateViewController(identifier: "InstructorsAddCourse") as? InstructorsAddCourse{
      
      next.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(next, animated: true)
    }
  }
}

extension InstructorsCoursesTabelViewController : UITableViewDelegate,UITableViewDataSource ,MyCellDelegate
{
 
  //MARK: -func to make Delet for cell
  func tableView(_ tableView: UITableView,
                  trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
   -> UISwipeActionsConfiguration? {
     let delete = UIContextualAction(style: .destructive,
                                     title:"Delete".localized)
                                    { ACTION,
                                      view,
                                      result in
      print("delete Tapped".localized)
      let userId = Constant.userId
      self.ref.child(self.courses[indexPath.row].courseId).removeValue { Error, data in
        if Error != nil
        {
          print(Error?.localizedDescription)
        }
      }
       result(true)
      tableView.reloadData()
     }
    return UISwipeActionsConfiguration(actions: [delete])
  }
  
  //MARK: - func for cell For Row
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
    cell?.courseName.text = self.courses[indexPath.row].courseName
    cell?.courseTimeKind.text = self.courses[indexPath.row].courseTimeKind
    cell?.courseContents.text = self.courses[indexPath.row].courseContents
    cell?.coursePrice.text = self.courses[indexPath.row].coursePrice
    cell?.courseTime.text = self.courses[indexPath.row].courseDate
    
    cell?.btnManageCourse.tag = indexPath.row
    self.currentCourseindex = indexPath.row
    cell?.btnChallenge.tag = 500
    cell?.btnLectures.tag = 600
    cell?.myCellDelegate = self
 
    return cell!
  }
  
  //Too: navigate to another screen with keep on Navigation Controller bonding
  func didPressButton(_ tag : Int)
  {
    if tag == 500
    {
      //Too: go to Challenges Table View Controller screen
      let story = UIStoryboard(name: "Main", bundle: nil)
      
      if let next = story.instantiateViewController(identifier: Constant.storyboard.ChallengesTableViewController) as? ChallengesTableViewController{
        
        next.modalPresentationStyle = .fullScreen
        next.TransferedCId = self.courses[self.currentCourseindex].courseId
        self.navigationController?.pushViewController(next, animated: true)
       }
      
    }else if tag == 600
    {
      //Too: go to Lecture Table View Controller screen
      let story = UIStoryboard(name: "Main", bundle: nil)
      
      if let next = story.instantiateViewController(identifier: Constant.storyboard.LectureTableViewController) as? LectureTableViewController{
         next.modalPresentationStyle = .fullScreen
        next.courseId = self.courses[self.currentCourseindex].courseId
        self.navigationController?.pushViewController(next, animated: true)
         
       }
    }else
    {
      //Too: go to Course Update View Controller screen
      let courseDetails = self.courses[tag]
     
      let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
      
      if let Manage = storyboard?.instantiateViewController(identifier: Constant.storyboard.CourseUpdateViewController) as? CourseUpdateViewController{
        Manage.courseDetails = courseDetails
        Manage.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(Manage, animated: true)
      }
    }
  }

  
  //MARK: -number Of Rows In Section
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.courses.count
  }
 
  
  //MARK: -number Of Section
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
}
