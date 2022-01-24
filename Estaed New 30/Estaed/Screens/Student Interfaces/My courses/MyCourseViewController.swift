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
  var model = CourseModel()
//  var paidCourses = [StudentCourseModel]()
  var isChallengebtnPressed = false , isLectureBtnPressed = false
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Too: hide back button come frome previous interface
    navigationItem.hidesBackButton = true
    
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
    
    
    
        if let data =  dataSnapShot.value as? NSDictionary , dataSnapShot.exists(){
        for (_,v) in data {
           
                let value = v as! NSDictionary
                  let model = StudentCourseModel(value: value)
                  if model.isPaid
                  {
                      self.CourseModelList.append(model)
                  }
               
         
         
        }
        
//        for item in self.CourseModelList
//        {
//          if item.isPaid
//          {
//            self.paidCourses.append(item)
//          }
//        }
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
      if tag == 200
      {
          if let next = storyboard.instantiateViewController(identifier:"StudentChallengAttachmentVC" ) as? StudentChallengAttachmentVC{
              next.modalPresentationStyle = .fullScreen
              next.TransferedCId = self.model.courseId
              self.navigationController?.pushViewController(next, animated: true)
            }
      }
       if tag == 100
      {
          if let next = storyboard.instantiateViewController(identifier:"myLectureViewController" ) as? myLectureViewController{
              next.modalPresentationStyle = .fullScreen
              next.courseId = self.model.courseId
              self.navigationController?.pushViewController(next, animated: true)
            }
      }
    
    
      
    
  }
  
    
  //MARK: -number Of Rows In Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.CourseModelList.count
    }
    
  
  //MARK: - func for content cell For Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
      let cell = tableView.dequeueReusableCell(withIdentifier: "MyCourseCell", for: indexPath) as? MyCourseCell
      ref.child("courses").getData { error, Data in
          if let data = Data.value as? NSDictionary , Data.exists(){
             
              for (_ , v) in data
              {
                  let v1 = v as! NSDictionary
                  for (_,v2) in v1
                  {
                      let v3  = v2 as! NSDictionary
                    self.model = CourseModel(value: v3)
                    if self.model.courseId == self.CourseModelList[indexPath.row].courseId
                      {
                      cell!.courseTimeKind.text = self.model.courseTimeKind
                      cell!.courseName.text = self.model.courseName
                          break
                      }
                  }
              }
              
         
          cell?.LecturBtn.tag = 100
          cell?.cellDelegete = self
            cell?.challingBtn.tag = 200
           
        }
      }
   
    return cell!
    
  }
  
  
}








