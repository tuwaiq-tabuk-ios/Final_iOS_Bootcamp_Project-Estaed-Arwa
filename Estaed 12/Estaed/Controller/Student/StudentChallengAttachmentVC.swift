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
  var ref: DatabaseReference!
  var TransferedCId = ""
   
  override func viewDidLoad() {
     super.viewDidLoad()
 
 //    tableViewCH.register(UINib(nibName: "myCell", bundle: nil), forCellReuseIdentifier: "myCell")
    tableViewStudentCH.register(UINib(nibName: "myCallengesAttachmentCell", bundle: nil), forCellReuseIdentifier: "myCell")
    tableViewStudentCH.delegate = self
    tableViewStudentCH.dataSource = self
     ref = Database.database().reference()
     getData()
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
//    let model = ChallengAttachmentModel(ChallengId: "", numberOfCH:numberOfCH , titleOfCH: titleOfCH, numberOfweek: <#T##String#>, difficultylevel: difficultylevel, subjectOfCH: subjectOfCH, cId: TransferedCId)
       cell.difficultyOfCh.text = difficultylevel
       cell.numberOfCh.text = numberOfCH
       cell.subjectOfCh.text = subjectOfCH
       cell.titleOfCh.text = titleOfCH
       
    return cell

   }
 


}



