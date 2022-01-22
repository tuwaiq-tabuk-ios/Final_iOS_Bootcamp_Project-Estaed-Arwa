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
  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
        super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
       
    }
  
  
  
  func getData()
  {
    Database.database().reference().child("courses").observe(.value) { DataSnapShot in
      
      if let data = DataSnapShot.value as? NSDictionary,DataSnapShot.exists(){
        
        for (_ , v) in data{
          let  value = v as! NSDictionary
          self.courseModelList.append(CourseModel(value: value))
        }
        
      }
    }
  }

}

extension StudentCoursesName : UITableViewDelegate
{
  
}

extension StudentCoursesName : UITableViewDataSource
{
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.courseModelList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "avilableCourseCell") as? AvailableCourseCellTableViewCell
    cell!.configre(value: self.courseModelList[indexPath.row])
    return cell!
  }
}
