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
    
    tableViewLec.register(UINib(nibName: "LectureCell", bundle: nil), forCellReuseIdentifier: "LectureCell")
    tableViewLec.delegate = self
    tableViewLec.dataSource = self
      ref = Database.database().reference().child(Constant.lectures)
     
    getLecture()
  }
  
  //MARK: -Programmatically switch to another interface with keep on Navigation Controller bonding
  @IBAction func AddBtn(_ sender: Any) {
    if let next = storyboard?.instantiateViewController(identifier: "Lecture") as? LectureViewController{
      
      next.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(next, animated: true)
    }
  }
  
  //MARK: -func to get data from Firbace
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

      }
      else
      {
        Constant.getMsg(title:"Error!".localized, Msg:"error while Getting Data".localized, context: self)
        
      }
      self.tableViewLec.reloadData()
    }
  }
}


extension LectureTableViewController : UITableViewDelegate,UITableViewDataSource {
  
  //MARK: -number Of Rows In Section
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.LectureModelList.count
  }
  
  //MARK: - func for content cell For Row
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
  
  



  
 
