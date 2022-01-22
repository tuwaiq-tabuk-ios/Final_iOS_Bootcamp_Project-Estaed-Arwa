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
  var isChallengebtnPressed = false , isLectureBtnPressed = false
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
    print("userId : " + Constant.StudentId)
    self.ref.child("StudentCourses").child(Constant.StudentId).getData(completion: { error, dataSnapShot in
    
    
    
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
        Constant.getMsg(title:"Error!".localized, Msg:"error while Getting Data".localized, context: self)
      }
     
    })
    
    
  }
}
  
extension MyCourseViewController : UITableViewDelegate,UITableViewDataSource , MyCellDelegate {
  func didPressButton(_ tag: Int) {
      let storyboard = UIStoryboard.init(name:
        "Main" , bundle: nil)
      if isChallengebtnPressed
      {
          if let next = storyboard.instantiateViewController(identifier:"StudentChallengAttachmentVC" ) as? StudentChallengAttachmentVC{
              next.modalPresentationStyle = .fullScreen
              next.TransferedCId = self.CourseModelList[tag].courseId
              self.present(next, animated: true, completion:  nil)
            }
      }
       if isLectureBtnPressed
      {
          if let next = storyboard.instantiateViewController(identifier:"myLectureViewController" ) as? myLectureViewController{
              next.modalPresentationStyle = .fullScreen
              next.courseId = self.CourseModelList[tag].courseId
              self.present(next, animated: true, completion:  nil)
            }
      }
    
    
      
    
  }
  
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.CourseModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "MyCourseCell", for: indexPath) as? MyCourseCell
      ref.child("courses").child(Constant.userId).child(self.CourseModelList[indexPath.row].courseId).getData { error, Data in
        if let data = Data.value as? NSDictionary{
          let course = CourseModel(value: data)
          cell!.courseName.text = course.courseName
          cell?.LecturBtn.tag = indexPath.row
          cell?.cellDelegete = self
          cell!.courseTimeKind.text = course.courseTimeKind
            cell?.challingBtn.tag = indexPath.row
            cell?.challingBtn.addTarget(self, action: #selector(self.challingbtnTapped), for: .touchUpInside)
          
            cell?.LecturBtn.addTarget(self, action: #selector(self.lecturebtnTapped), for: .touchUpInside)
        }
      }
   
    return cell!
    
  }
  
    @objc func challingbtnTapped()
    {
        isChallengebtnPressed = true
        isLectureBtnPressed = false
        
    }
    @objc func lecturebtnTapped()
    {
        isChallengebtnPressed = false
        isLectureBtnPressed = true
        
    }
}







