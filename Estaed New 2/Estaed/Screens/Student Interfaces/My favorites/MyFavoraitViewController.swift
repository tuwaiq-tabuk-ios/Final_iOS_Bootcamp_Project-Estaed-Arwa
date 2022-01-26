//
//  MyFavoraitViewController.swift
//
//
//  Created by arwa balawi on 12/06/1443 AH.
//

import UIKit
import Firebase
class MyFavoraitViewController: UIViewController {
  
  
  // MARK: - Properties
  
  
  var listOfChallenges = [String]()
  var attachmentChallenges = [ChallengAttachment]()
  var ref: DatabaseReference!
  
  
  
  // MARK: - IBOtlets
  
  @IBOutlet weak var tableViewFavorait: UITableView!
  
  
  
  
  // MARK: - View controller lifecycle
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //hide back button come frome previous interface
    navigationItem.hidesBackButton = true
    
    ref = Database.database().reference()
    tableViewFavorait.dataSource = self
    tableViewFavorait.register(UINib(nibName: "myCallengesAttachmentCell",
                                     bundle: nil),
                                     forCellReuseIdentifier: "myCell")
    getData()
  }
  
  
  
  //MARK: - Methods
  
  
  func getData() {
    ref
      .child("Favorite")
      .child(K.RealtimeDatabase.studentId)
      .getData { Error, Data in
        if let dictionary = Data.value as? NSDictionary,
                                           Data.exists() {
          
          for (_ , anyValue) in dictionary {
            
            let v = anyValue as! NSDictionary
            self.listOfChallenges.append(v["challingeId"] as! String)
          }
        }
      }
    
    ref.child("challenge").getData { error, Data in
      if let data = Data.value as? NSDictionary ,
                                   Data.exists(){
        
        
        for (_,v) in data  {
          let v1  = v as! NSDictionary
          for (_,value) in v1 {
            let dictionary = value as! NSDictionary
            
            let model = ChallengAttachment(value: dictionary )
            for item in self.listOfChallenges
            {
              if model.challengId == item
              {
                self.attachmentChallenges.append(model)
                break
              }
            }
          }
        }
        
        self.tableViewFavorait.reloadData()
      }
    }
  }
  
}



//MARK: - extension


extension MyFavoraitViewController : UITableViewDataSource,
                                     MyCellDelegate {
  
  func didPressButton(_ tag: Int) {
    if let next = self.storyboard?
        .instantiateViewController(identifier:K.Storyboard.studentDetailsChallengeVC ) as? StudentDetailsChallengeVC
    {
      next.ChallingeId = self.attachmentChallenges[tag].challengId
      next.modelAttatch = self.attachmentChallenges[tag]
      next.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(next,
                                                    animated: false)
    }
  }
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    
    return self.attachmentChallenges.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard  let cell = tableView.dequeueReusableCell(withIdentifier:
                                                      "myCell",
                                                    for: indexPath) as? MyCallengesAttachmentCell else{
      print("error in returning Cell".localized)
      return UITableViewCell()
    }
    
    
    
    let titleOfCH =
      self.attachmentChallenges[indexPath.row].titleOfCH
    let subjectOfCH =
      self.attachmentChallenges[indexPath.row].subjectOfCH
    let numberOfCH =
      self.attachmentChallenges[indexPath.row].numberOfCH
    let difficultylevel =
      self.attachmentChallenges[indexPath.row].difficultylevel
    cell.challingeId =  self.attachmentChallenges[indexPath.row].challengId
    
    
    cell.difficultyOfCh.text = difficultylevel
    cell.numberOfCh.text = numberOfCH
    cell.subjectOfCh.text = subjectOfCH
    cell.titleOfCh.setTitle(titleOfCH,
                            for: .normal)
    cell.btnHeart.setImage(UIImage(systemName: "heart.fill"),
                           for: .normal)
    cell.myCellDelegate = self
    return cell
    
    
  }
  
  
}

