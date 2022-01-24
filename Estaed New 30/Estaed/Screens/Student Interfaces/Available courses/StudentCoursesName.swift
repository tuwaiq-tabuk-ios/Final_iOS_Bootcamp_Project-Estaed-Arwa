//
//  StudentCoursesName.swift
//  Estaed
//
//  Created by arwa balawi on 29/05/1443 AH.
//

import UIKit
import Firebase
class StudentCoursesName: UIViewController {

let story = UIStoryboard(name: "Main", bundle: nil)
  
var courseModelList = [CourseModel]()
var nonReservedCourses = [CourseModel]()
var coursesIdList = [String]()
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    //Too: hide back button come frome previous interface
    navigationItem.hidesBackButton = true
    
    tableView.dataSource = self
      tableView.register(UINib(nibName: "AvailableCourseCellTableViewCell", bundle: nil), forCellReuseIdentifier: "avilableCourseCell")
      getData()
    }
  
  //MARK: -func to get data frome Firebace
  func getData()
  {
  Database.database().reference().child("StudentCourses")
    .child(Constant.StudentId).getData
    { error, DataSnapShot in
      
        if let data = DataSnapShot.value as? NSDictionary,
        DataSnapShot.exists()
        {
        for (key ,_) in data
              {
                  self.coursesIdList.append(key as! String)
              }
          }
      }
      
  Database.database().reference().child("courses").observe(.value)
  { DataSnapShot in
    
      if let data = DataSnapShot.value as? NSDictionary,DataSnapShot.exists()
      {
        for (_ , v) in data{
            for (_ , v1) in v as! NSDictionary
            {
                let  value = v1 as! NSDictionary
                let model = CourseModel(value: value)
                self.courseModelList.append(model)
            }
        }
          
          for item in self.courseModelList
          {
              var isFound = false
              for id in self.coursesIdList
              {
                  if id == item.courseId
                  {
                      isFound = true
                  }
              }
              if isFound == false
              {
                  self.nonReservedCourses.append(item)
              }
          }
          self.tableView.reloadData()
      }
    }
  }
}


extension StudentCoursesName : UITableViewDataSource, MyCellDelegate
{
  //MARK: -func to action the details button in cell
    func didPressButton(_ tag: Int)
    {
      //MARK: -Programmatically switch to another interface with keep on Navigation Controller bonding
        if let next = self.story.instantiateViewController(withIdentifier: "StudentCourseDetails") as? StudentCourseDetails
        {
            next.model = self.courseModelList[tag]
            next.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  //MARK: -number Of Rows In Section
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.nonReservedCourses.count
  }
  
  //MARK: - func for content cell For Row
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "avilableCourseCell") as? AvailableCourseCellTableViewCell
    cell!.configre(value: self.courseModelList[indexPath.row])
    cell!.delegate = self
    return cell!
  }
    
   
}

