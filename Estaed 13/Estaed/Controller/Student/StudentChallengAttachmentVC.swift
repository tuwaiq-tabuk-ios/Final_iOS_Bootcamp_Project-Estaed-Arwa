//
//  StudentChallengeViewController.swift
//  Estaed
//
//  Created by arwa balawi on 01/06/1443 AH.
//

import UIKit
import FirebaseDatabase

class StudentChallengAttachmentVC: UIViewController {

  
  @IBOutlet weak var tableViewStudentCH: UITableView!
  
  var ChallengAttachmentModelList = [ChallengAttachmentModel]()
 var arrSection = [NumberOfWeekModel]()
  var ref: DatabaseReference!
  var refreshControl = UIRefreshControl()
  var TransferedCId = ""
   
  override func viewDidLoad() {
     super.viewDidLoad()
 
    tableViewStudentCH.register(UINib(nibName: "myCallengesAttachmentCell", bundle: nil), forCellReuseIdentifier: "myCell")
    tableViewStudentCH.delegate = self
    tableViewStudentCH.dataSource = self
     ref = Database.database().reference()
     getData()
//
//    refreshControl.tintColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
//    refreshControl.addTarget(self, action: #selector(getDataOfWeakNumber) , for: .valueChanged)
//    tableViewStudentCH.addSubview(refreshControl)

   }
  
  @objc func getDataOfWeakNumber() {
    arrSection.append(NumberOfWeekModel(arrNumberOfWeek: ["first week","second week","third week","fourth week","fifth week","sixth week","Seventh week","eighth week", "ninth week" ,"tenth week","eleventh week","Twelfth week"]
    
    , arrNumberOfWeek2: ["first week","second week","third week","fourth week","fifth week","sixth week"]))
    refreshControl.endRefreshing()
    tableViewStudentCH.reloadData()
    
    
    
  }
 
   func getData()
   {
     ref.child(Constant.challenge).child(Constant.userId).child(TransferedCId).observe(.value, with: {
       Datashot in
       if Datashot.value != nil
       {
         if !self.ChallengAttachmentModelList.isEmpty
         {
           self.ChallengAttachmentModelList.removeAll()
         }
 
         if let data = Datashot.value as? NSDictionary{
           for (_,v) in data {
 
             let value = v as! NSDictionary
             self.ChallengAttachmentModelList.append(ChallengAttachmentModel(value: value))
           }
         }
 
       }
 
       self.tableViewStudentCH.reloadData()
 
     }
     )}
 
 }
 
extension StudentChallengAttachmentVC : UITableViewDelegate,UITableViewDataSource {
 
 
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.ChallengAttachmentModelList.count
   }
  //
//  func numberOfSections(in tableView: UITableView) -> Int {
//    self.arrSection.count
//  }
  
//  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//    return arrSection[section]
//
//}
//
  
 
 
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // let cell = tableView.dequeue() as! TableChallengeCell
   guard  let cell = tableView.dequeueReusableCell(withIdentifier:
                                               "myCell",
                                                   for: indexPath) as? myCallengesAttachmentCell else{
     print("error in returning Cell")
     return UITableViewCell()
   }
 
 
 
     let titleOfCH = self.ChallengAttachmentModelList[indexPath.row].titleOfCH
     let subjectOfCH =
       self.ChallengAttachmentModelList[indexPath.row].subjectOfCH
     let numberOfweek =
       self.ChallengAttachmentModelList[indexPath.row].numberOfweek
     let numberOfCH =
       self.ChallengAttachmentModelList[indexPath.row].numberOfCH
     let difficultylevel =
       self.ChallengAttachmentModelList[indexPath.row].difficultylevel
    cell.challingeId =  self.ChallengAttachmentModelList[indexPath.row].ChallengId

       cell.difficultyOfCh.text = difficultylevel
       cell.numberOfCh.text = numberOfCH
       cell.subjectOfCh.text = subjectOfCH
       cell.titleOfCh.text = titleOfCH
       
    return cell

   }
  
 
 

}

