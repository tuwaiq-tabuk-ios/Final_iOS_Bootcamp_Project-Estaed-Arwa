//
//  ActivateCourseViewController.swift
//  Estaed
//
//  Created by arwa balawi on 30/05/1443 AH.
//

import UIKit
import FirebaseDatabase


class ActivateCourseViewController: UIViewController {
  
  @IBOutlet weak var tableViewActivate: UITableView!
  
  var StudentCourseModelList = [StudentCourseModel]()
  var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
      tableViewActivate.register(UINib(nibName: "ActivateCourseVCCell", bundle: nil), forCellReuseIdentifier: "ActivateCourseVCCell")
      
      tableViewActivate.delegate = self
      tableViewActivate.dataSource = self
  //    ref = Database.database().reference().child("???").child(????)
      getData()
    }
  
  func getData()
  {
    
    self.ref.observe(.value) { dataSnapShot in
      if !self.StudentCourseModelList.isEmpty
      {
        self.StudentCourseModelList.removeAll()
      }
      if let data =  dataSnapShot.value as? NSDictionary{
        for (_,v) in data {
          let value = v as! NSDictionary
          self.StudentCourseModelList.append(StudentCourseModel(value: value))
        }
             
      }else
      {
        Constant.getMsg(title: "Error!", Msg: "error while Getting Data", context: self)
        
      }
      self.tableViewActivate.reloadData()
    }
  }
}
      
    
    

extension ActivateCourseViewController : UITableViewDelegate , UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.StudentCourseModelList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ActivateCourseVCCell", for: indexPath) as? ActivateCourseVCCell
    
    cell?.courseIdCell.text =
      self.StudentCourseModelList[indexPath.row].courseId
    cell?.studentIdCell.text =
      self.StudentCourseModelList[indexPath.row].StudentId
//cell?.paidBtn = false???
    self.StudentCourseModelList[indexPath.row].isPaid
    
    
    return cell!
  }

  
}
  
  



  
 

