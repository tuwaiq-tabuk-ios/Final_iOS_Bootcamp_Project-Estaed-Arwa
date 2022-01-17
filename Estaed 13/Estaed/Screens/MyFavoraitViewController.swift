//
//  MyFavoraitViewController.swift
//  
//
//  Created by arwa balawi on 12/06/1443 AH.
//

import UIKit
import Firebase
class MyFavoraitViewController: UIViewController {

  var ChallingesIdList = [String]()
  var ChallengAttachmentModelList = [ChallengAttachmentModel]()
 
  var ref: DatabaseReference!
  @IBOutlet weak var tableViewFavorait: UITableView!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        tableViewFavorait.dataSource = self
        tableViewFavorait.register(UINib(nibName: "myCallengesAttachmentCell", bundle: nil), forCellReuseIdentifier: "myCell")
      getData()
    }
    
func  getData()
{

   ref.child("Favorite").child(Constant.StudentId).getData { Error, Data in
    if let data = Data.value as? NSDictionary ,Data.exists(){
      for (_ , value) in data
      {
        let v = value as! NSDictionary
        self.ChallingesIdList.append(v["challingeId"] as! String)
      }
      
    }
  }
  
  ref.child("challenge").child(Constant.userId).getData { error, Data in
    if let data = Data.value as? NSDictionary , Data.exists(){
      
      for (_,v) in data {
        let v1  = v as! NSDictionary
        for (_,value) in v1 {
          let value = value as! NSDictionary
          let model = ChallengAttachmentModel(value: value)
          for item in self.ChallingesIdList
          {
            if model.ChallengId == item
            {
              self.ChallengAttachmentModelList.append(model)
              break
            }
          }
            self.tableViewFavorait.reloadData()
        }
      }
      
    }
  }
}
 
  

}

extension MyFavoraitViewController : UITableViewDataSource
{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.ChallengAttachmentModelList.count
  }

  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
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
