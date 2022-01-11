//
//  LectureViewController.swift
//  Estaed
//
//  Created by arwa balawi on 29/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class LectureTableViewController: UIViewController {
  
  
  @IBOutlet weak var tableViewLec: UITableView!
  
  var LectureModelList = [LectureModel]()
  var ref: DatabaseReference!
  var courseId = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //  let nib = UINib(nibName: "myLectCell", bundle: nil)
      tableViewLec.register(UINib(nibName: "LectureCell", bundle: nil), forCellReuseIdentifier: "LectureCell")
    tableViewLec.delegate = self
    tableViewLec.dataSource = self
      ref = Database.database().reference().child(Constant.lectures)//.child(Constant.courseId)
     
    getLecture()
  }
  
  
  func getLecture()
  {
    if !self.LectureModelList.isEmpty
    {
      self.LectureModelList.removeAll()
    }
    self.ref.observe(.value) { dataSnapShot in
     
      if let data =  dataSnapShot.value as? NSDictionary{
        for (_,v) in data {
          let value = v as! NSDictionary
          self.LectureModelList.append(LectureModel(value: value))
        }
             
        
      }else
      {
        Constant.getMsg(title: "Error!", Msg: "error while Getting Data", context: self)
        
      }
      self.tableViewLec.reloadData()
    }
  }
}


extension LectureTableViewController : UITableViewDelegate,UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.LectureModelList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
       let cell = tableView.dequeueReusableCell(withIdentifier: "LectureCell", for: indexPath) as? LectureCell
    
    cell!.nameLabel.text =
      self.LectureModelList[indexPath.row].lectureName
      cell!.urlLabel.text = self.LectureModelList[indexPath.row].lectureURL
      cell!.dateLabel.text = self.LectureModelList[indexPath.row].lectureDate
      cell!.timeLabel.text = self.LectureModelList[indexPath.row].lectureTime
      return cell!
   
  }

    
  
}
  
  



  
 
