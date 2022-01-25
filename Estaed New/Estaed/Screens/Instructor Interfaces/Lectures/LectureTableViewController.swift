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
  
  var lectureModelList = [LectureModel]()
  var ref: DatabaseReference!
  var courseId = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableViewLec.register(UINib(nibName: "LectureCell", bundle: nil), forCellReuseIdentifier: "LectureCell")
    tableViewLec.delegate = self
    tableViewLec.dataSource = self
    ref = Database.database().reference().child(K.RealtimeDatabase.lectures)
     
    getLecture()
  }
  
  //MARK: -Programmatically switch to another interface with keep on Navigation Controller bonding
  @IBAction func addBtn(_ sender: Any) {
    if let next = storyboard?.instantiateViewController(identifier: K.Storyboard.LectureViewController) as? LectureViewController{
      
      next.modalPresentationStyle = .fullScreen
        next.courseId = self.courseId
      self.navigationController?.pushViewController(next, animated: true)
    }
  }
  
  //MARK: -func to get data from Firbace
  func getLecture()
  {
    if !self.lectureModelList.isEmpty
    {
      self.lectureModelList.removeAll()
    }
      self.ref.child(self.courseId).observe(.value) { dataSnapShot in
     
      if let data =  dataSnapShot.value as? NSDictionary{
        for (_,v) in data {
          let value = v as! NSDictionary
          self.lectureModelList.append(LectureModel(value: value))
        }

      }
      self.tableViewLec.reloadData()
    }
  }
}


extension LectureTableViewController : UITableViewDelegate,UITableViewDataSource {
  
  //MARK: -number Of Rows In Section
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.lectureModelList.count
  }
  
  //MARK: - func for content cell For Row
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
       let cell = tableView.dequeueReusableCell(withIdentifier: "LectureCell", for: indexPath) as? LectureCell
    
    cell!.nameLabel.text =
      self.lectureModelList[indexPath.row].lectureName
      cell!.urlLabel.text = self.lectureModelList[indexPath.row].lectureURL
      cell!.dateLabel.text = self.lectureModelList[indexPath.row].lectureDate
      cell!.timeLabel.text = self.lectureModelList[indexPath.row].lectureTime
      return cell!
   
  }

  
}
  
  



  
 
