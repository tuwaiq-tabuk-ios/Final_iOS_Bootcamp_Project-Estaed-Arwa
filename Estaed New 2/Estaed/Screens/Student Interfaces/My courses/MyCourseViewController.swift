//
//  MyCourseViewController.swift
//  Estaed
//
//  Created by arwa balawi on 02/06/1443 AH.
//

import UIKit
import FirebaseDatabase

class MyCourseViewController: UIViewController {
  
  
  // MARK: - Properties
  
  var ref : DatabaseReference!
  var courseModelList = [StudentCourse]()
  var model = Course()
  var isChallengebtnPressed = false ,
      isLectureBtnPressed = false
  
  
  // MARK: - IBOtlets
  
  @IBOutlet weak var tableViewMyCourse: UITableView!
  
  
  // MARK: - View controller lifecycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //hide back button come frome previous interface
    navigationItem.hidesBackButton = true
    
    tableViewMyCourse.register(UINib(nibName: "MyCourseCell",
                                     bundle: nil),
                               forCellReuseIdentifier: "MyCourseCell")
    tableViewMyCourse.delegate = self
    tableViewMyCourse.dataSource = self
    ref = Database.database().reference()
    
    getdata()
  }
  
  
  
  //MARK: - Methods
  
  
  
  func getdata()
  {
    if !self.courseModelList.isEmpty
    {
      self.courseModelList.removeAll()
    }
    print("userId : " + K.RealtimeDatabase.studentId)
    self.ref.child("StudentCourses").child(K.RealtimeDatabase.studentId).getData(completion: { error, dataSnapShot in
      
      if let dictionary =  dataSnapShot.value as? NSDictionary,
         dataSnapShot.exists(){
        for (_,v) in dictionary {
          
          let dictionary = v as! NSDictionary
          let model = StudentCourse(value: dictionary)
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


//MARK: - extension



extension MyCourseViewController : UITableViewDelegate,
                                   UITableViewDataSource ,
                                   MyCellDelegate {
  
  func didPressButton(_ tag: Int) {
    
    let storyboard = UIStoryboard.init(name: "Main",
                                       bundle: nil)
    if tag == 200
    {
      if let challenge = storyboard.instantiateViewController(identifier:K.Storyboard.studentChallengAttachmentVC) as? StudentChallengAttachmentVC{
        
        challenge.modalPresentationStyle = .fullScreen
        challenge.transferedCId = self.model.courseId
        self.navigationController?.pushViewController(challenge,
                                                      animated: true)
      }
    }
    if tag == 100
    {
      if let lecture = storyboard.instantiateViewController(identifier:K.Storyboard.myLecture ) as? MyLectureViewController{
        
        lecture.modalPresentationStyle = .fullScreen
        lecture.courseId = self.model.courseId
        self.navigationController?.pushViewController(lecture,
                                                      animated: true)
      }
    }
    
  }
  
  
  // number Of Rows In Section
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    
    return self.courseModelList.count
  }
  
  
  //content cell For Row
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: K.Storyboard.MyCourseCell,
                                             for: indexPath) as? MyCourseCell
    ref.child("courses").getData { error,
                                   Data in
      if let dictionary = Data.value as? NSDictionary , Data.exists(){
        
        for (_ , v) in dictionary
        {
          let v1 = v as! NSDictionary
          for (_,v2) in v1
          {
            let v3  = v2 as! NSDictionary
            self.model = Course(value: v3)
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








