//
//  LectureViewController.swift
//  Estaed
//
//  Created by arwa balawi on 29/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class LectureTableViewController: UIViewController {
  
  
  // MARK: - Properties
  
  var lectureModelList = [Lecture]()
  var ref: DatabaseReference!
  var courseId = ""
  
  
  // MARK: - IBOtlets
  
  @IBOutlet weak var tableViewLec: UITableView!
  
  
  //MARK: - View controller lifecycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableViewLec.register(UINib(nibName: "LectureCell",
                                bundle: nil),
                          forCellReuseIdentifier: "LectureCell")
    
    tableViewLec.delegate = self
    tableViewLec.dataSource = self
    ref = Database.database().reference().child(K.RealtimeDatabase.lectures)
    
    getLecture()
  }
  
  
  
  //MARK: - Methods
  
  
  func getLecture()
  {
    if !self.lectureModelList.isEmpty
    {
      self.lectureModelList.removeAll()
    }
    self.ref.child(self.courseId).observe(.value) { dataSnapShot in
      
      if let dictionary =  dataSnapShot.value as? NSDictionary{
        for (_,v) in dictionary {
          let value = v as! NSDictionary
          self.lectureModelList.append(Lecture(value: value))
        }
        
      }
      self.tableViewLec.reloadData()
    }
  }
  
  
  
  //MARK: -IBAction
  
  
  //To:Programmatically switch to another interface with keep on Navigation Controller bonding
  @IBAction func addBtn(_ sender: Any) {
    
    if let next = storyboard?.instantiateViewController(identifier: K.Storyboard.LectureViewController) as? LectureViewController{
      
      next.modalPresentationStyle = .fullScreen
      next.courseId = self.courseId
      self.navigationController?.pushViewController(next,
                                                    animated: true)
    }
  }
  
}


//MARK: - extension




extension LectureTableViewController : UITableViewDelegate,
                                       UITableViewDataSource {
  
  //number Of Rows In Section
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    
    return self.lectureModelList.count
  }
  
  //content cell For Row
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: K.Storyboard.LectureCell,
                                             for: indexPath) as? LectureCell
    
    cell!.nameLabel.text =
      self.lectureModelList[indexPath.row].lectureName
    cell!.urlLabel.text = self.lectureModelList[indexPath.row].lectureURL
    cell!.dateLabel.text = self.lectureModelList[indexPath.row].lectureDate
    cell!.timeLabel.text = self.lectureModelList[indexPath.row].lectureTime
    return cell!
    
  }
  
  
}







