//
//  myLectureViewController.swift
//  Estaed
//
//  Created by arwa balawi on 06/06/1443 AH.
//

import UIKit
import FirebaseDatabase

class myLectureViewController: UIViewController {
  
  
  @IBOutlet weak var tableViewMyLecture: UITableView!
  
  var ref : DatabaseReference!
  var MyLectureModelList = [LectureModel]()
  var courseId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
      
      tableViewMyLecture.register(UINib(nibName: "MyLectureCell",
                                        bundle: nil),
                                        forCellReuseIdentifier: "MyLectureCell")
      tableViewMyLecture.delegate = self
      tableViewMyLecture.dataSource = self
      ref = Database.database().reference().child(Constant.lectures).child(courseId)
     
    getData()
  }
  
  //MARK: -git data from firebase
  func getData()
  {
    print("courseId : \(courseId)")
    if !self.MyLectureModelList.isEmpty
    {
      self.MyLectureModelList.removeAll()
    }
    self.ref.getData { error, dataSnapShot in
    
      if let data =  dataSnapShot.value as? NSDictionary{
        for (_,v) in data {
          let value = v as! NSDictionary
          self.MyLectureModelList.append(LectureModel(value: value))
        }
      }
      self.tableViewMyLecture.reloadData()
    }
  }
}


extension myLectureViewController : UITableViewDelegate,UITableViewDataSource {
  
  //MARK: -number Of Rows In Section
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.MyLectureModelList.count
  }
  
  //MARK: - func for content cell For Row
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: Constant.storyboard.MyLectureCell, for: indexPath) as? MyLectureCell
    
    cell!.lectureName.text =
      self.MyLectureModelList[indexPath.row].lectureName
    cell!.lectureDate.text =
      self.MyLectureModelList[indexPath.row].lectureDate
    cell!.lectureTime.text =
      self.MyLectureModelList[indexPath.row].lectureTime
      cell!.url = self.MyLectureModelList[indexPath.row].lectureURL
    return cell!
   
  }

}
  
  



  
 
