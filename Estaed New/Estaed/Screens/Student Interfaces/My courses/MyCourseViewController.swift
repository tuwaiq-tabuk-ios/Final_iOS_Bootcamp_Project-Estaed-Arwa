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
  var courseModelList = [StudentCourseModel]()
  var model = CourseModel()
  var isChallengebtnPressed = false ,
      isLectureBtnPressed = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Too: hide back button come frome previous interface
    navigationItem.hidesBackButton = true
    
    tableViewMyCourse.register(UINib(nibName: "MyCourseCell",
                                     bundle: nil),
                                     forCellReuseIdentifier: "MyCourseCell")
    tableViewMyCourse.delegate = self
    tableViewMyCourse.dataSource = self
    ref = Database.database().reference()
    
    getdata()
  }
  
  func getdata()
  {
    if !self.courseModelList.isEmpty
    {
      self.courseModelList.removeAll()
    }
    print("userId : " + K.RealtimeDatabase.studentId)
    self.ref.child("StudentCourses").child(K.RealtimeDatabase.studentId).getData(completion: { error, dataSnapShot in
    
        if let data =  dataSnapShot.value as? NSDictionary,
                       dataSnapShot.exists(){
        for (_,v) in data {
           
                let value = v as! NSDictionary
                  let model = StudentCourseModel(value: value)
                  if model.isPaid
                  {
                      self.courseModelList.append(model)
                  }
               
         
         
        }
  
        self.tableViewMyCourse.reloadData()
      }else
      {
        K.getMsg(title:"Error!".localized,
                 Msg:"error while Getting Data".localized,
                 context: self)
      }
     
    })
    
    
  }
}
  
extension MyCourseViewController : UITableViewDelegate,UITableViewDataSource , MyCellDelegate {
  
  func didPressButton(_ tag: Int) {
      let storyboard = UIStoryboard.init(name: "Main",
                                         bundle: nil)
      if tag == 200
      {
        if let challenge = storyboard.instantiateViewController(identifier:K.Storyboard.studentChallengAttachmentVC) as? StudentChallengAttachmentVC{
          
              challenge.modalPresentationStyle = .fullScreen
              challenge.transferedCId = self.model.courseId
              self.navigationController?.pushViewController(challenge, animated: true)
            }
      }
       if tag == 100
      {
        if let lecture = storyboard.instantiateViewController(identifier:K.Storyboard.myLecture ) as? MyLectureViewController{
          
              lecture.modalPresentationStyle = .fullScreen
              lecture.courseId = self.model.courseId
              self.navigationController?.pushViewController(lecture, animated: true)
            }
      }
  
  }
  
    
  //MARK: -number Of Rows In Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.courseModelList.count
    }
    
  
  //MARK: - func for content cell For Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
      let cell = tableView.dequeueReusableCell(withIdentifier: K.Storyboard.MyCourseCell,
                                               for: indexPath) as? MyCourseCell
      ref.child("courses").getData { error, Data in
          if let data = Data.value as? NSDictionary , Data.exists(){
             
              for (_ , v) in data
              {
                  let v1 = v as! NSDictionary
                  for (_,v2) in v1
                  {
                      let v3  = v2 as! NSDictionary
                    self.model = CourseModel(value: v3)
                    if self.model.courseId == self.courseModelList[indexPath.row].courseId
                      {
                      cell!.courseTimeKind.text = self.model.courseTimeKind
                      cell!.courseName.text = self.model.courseName
                          break
                      }
                  }
              }
              
         
          cell?.lecturBtn.tag = 100
          cell?.cellDelegete = self
            cell?.challingBtn.tag = 200
           
        }
      }
   
    return cell!
    
  }
  
}








