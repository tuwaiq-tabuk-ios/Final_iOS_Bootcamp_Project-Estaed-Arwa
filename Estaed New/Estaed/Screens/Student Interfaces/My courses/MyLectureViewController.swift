//
//  myLectureViewController.swift
//  Estaed
//
//  Created by arwa balawi on 06/06/1443 AH.
//

import UIKit
import Firebase

class MyLectureViewController: UIViewController {
  
  
  @IBOutlet weak var tableViewMyLecture: UITableView!
  
  var ref : DatabaseReference!
  var myLectureModelList = [LectureModel]()
  var courseId = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      tableViewMyLecture.register(UINib(nibName: "MyLectureCell",
                                        bundle: nil),
                                        forCellReuseIdentifier: "MyLectureCell")
      tableViewMyLecture.delegate = self
      tableViewMyLecture.dataSource = self
       
      ref = Database.database().reference().child(K.RealtimeDatabase.lectures).child(courseId)
     print("lecture course ID : \(courseId)")
    getData()
  }
  
  //MARK: -git data from firebase
  func getData()
  {
    
    if !self.myLectureModelList.isEmpty
    {
      self.myLectureModelList.removeAll()
    }
    self.ref.getData { error, dataSnapShot in
    
        if let data =  dataSnapShot.value as? NSDictionary,
                                              dataSnapShot.exists(){
        for (_,v) in data {
          let value = v as! NSDictionary
          self.myLectureModelList.append(LectureModel(value: value))
        }
      }
      self.tableViewMyLecture.reloadData()
    }
  }
}


extension MyLectureViewController : UITableViewDelegate,UITableViewDataSource {
  
  //MARK: -number Of Rows In Section
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.myLectureModelList.count
  }
  
  //MARK: - func for content cell For Row
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: K.Storyboard.myLectureCell,
                                             for: indexPath) as? MyLectureCell
    
    cell!.lectureName.text =
      self.myLectureModelList[indexPath.row].lectureName
    cell!.lectureDate.text =
      self.myLectureModelList[indexPath.row].lectureDate
    cell!.lectureTime.text =
      self.myLectureModelList[indexPath.row].lectureTime
      cell!.url = self.myLectureModelList[indexPath.row].lectureURL
    
      return cell!
   
  }

}
  
  



  
 
