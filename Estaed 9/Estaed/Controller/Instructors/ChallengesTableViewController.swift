//
//  ChallengesViewController.swift
//  Estaed
//
//  Created by arwa balawi on 23/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class ChallengesTableViewController: UIViewController {


  @IBOutlet weak var tableViewCH: UITableView!
  
  var ChallengAttachmentModelList = [ChallengAttachmentModel]()
  var ref: DatabaseReference!
  var TransferedCId = ""
  
  @IBAction func add(_ sender: Any) {
    
    if TransferedCId.count > 0
    {
      let story = UIStoryboard(name: "Main", bundle: nil)
      let courseAttatch = story.instantiateViewController(identifier: "courseAttatch") as! ChallengAttachmentViewController
      courseAttatch.TransferedCId = TransferedCId
      courseAttatch.modalPresentationStyle = .fullScreen
      self.present(courseAttatch, animated: true, completion: nil)
    }
    
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    tableViewCH.register(UINib(nibName: "myCell", bundle: nil), forCellReuseIdentifier: "myCell")
    tableViewCH.register(ChallengeCell.self, forCellReuseIdentifier: "myCell")
    tableViewCH.delegate = self
    tableViewCH.dataSource = self
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
      
      self.tableViewCH.reloadData()
      
    }
    )}
  
}

extension ChallengesTableViewController : UITableViewDelegate,UITableViewDataSource , MyCellDelegate {

  
  
  
  func didPressButton(_ tag: Int) {
   print("didFunction called")
    let story = UIStoryboard.init(name: "Main", bundle: nil)
    let nextViewController = story.instantiateViewController(identifier: "ChallengDetails") as? ChallengDetailsViewController
    nextViewController?.TransferedCId = TransferedCId
    nextViewController?.ChallingeId =  self.ChallengAttachmentModelList[tag].ChallengId
    nextViewController!.modalPresentationStyle = .fullScreen
    self.present(nextViewController!, animated: true, completion: nil)
  }
  
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.ChallengAttachmentModelList.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   // let cell = tableView.dequeue() as! TableChallengeCell
  guard  let cell = tableView.dequeueReusableCell(withIdentifier:
                                              "myCell",
                                                  for: indexPath) as? ChallengeCell else{
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
    let model = ChallengAttachmentModel(ChallengId: "",
                                        numberOfCH: numberOfCH,
                                        titleOfCH: titleOfCH,
                                        numberOfweek: numberOfweek,
                                        difficultylevel: difficultylevel,
                                        subjectOfCH: subjectOfCH,
                                        cId: TransferedCId)
    cell.initCell(model: model)
    cell.BtnChallengDetails.tag = indexPath.row
      cell.myCellDelegate = self
    return cell
    
  }
  
  
  
  
  
  
}

























