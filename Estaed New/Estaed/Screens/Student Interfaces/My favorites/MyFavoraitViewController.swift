//
//  MyFavoraitViewController.swift
//
//
//  Created by arwa balawi on 12/06/1443 AH.
//

import UIKit
import Firebase
class MyFavoraitViewController: UIViewController {
    
    var challingesIdList = [String]()
    var challengAttachmentModelList = [ChallengAttachmentModel]()
    
    var ref: DatabaseReference!
    @IBOutlet weak var tableViewFavorait: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      //Too: hide back button come frome previous interface
      navigationItem.hidesBackButton = true
      
        ref = Database.database().reference()
        tableViewFavorait.dataSource = self
        tableViewFavorait.register(UINib(nibName: "myCallengesAttachmentCell",
                                         bundle: nil),
                                         forCellReuseIdentifier: "myCell")
        getData()
    }
    
    func  getData()
    {
        
      ref.child("Favorite").child(K.RealtimeDatabase.studentId).getData { Error, Data in
            if let data = Data.value as? NSDictionary ,Data.exists(){
                for (_ , value) in data
                {
                    let v = value as! NSDictionary
                    self.challingesIdList.append(v["challingeId"] as! String)
                }
                
            }
        }
        
        ref.child("challenge").getData { error, Data in
            if let data = Data.value as? NSDictionary , Data.exists(){
                
                
                for (_,v) in data  {
                    let v1  = v as! NSDictionary
                    for (_,value) in v1 {
                        let value = value as! NSDictionary
                      
                      let model = ChallengAttachmentModel(value: value )
                            for item in self.challingesIdList
                            {
                                if model.challengId == item
                                {
                                    self.challengAttachmentModelList.append(model)
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

extension MyFavoraitViewController : UITableViewDataSource,MyCellDelegate
{
    func didPressButton(_ tag: Int) {
        if let next = self.storyboard?
            .instantiateViewController(identifier:K.Storyboard.studentDetailsChallengeVC ) as? StudentDetailsChallengeVC
        {
            next.ChallingeId = self.challengAttachmentModelList[tag].challengId
            next.modelAttatch = self.challengAttachmentModelList[tag]
            next.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(next,
                                                          animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.challengAttachmentModelList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard  let cell = tableView.dequeueReusableCell(withIdentifier:
                                                            "myCell",
                                                        for: indexPath) as? MyCallengesAttachmentCell else{
            print("error in returning Cell".localized)
            return UITableViewCell()
        }
        
        
        
        let titleOfCH = self.challengAttachmentModelList[indexPath.row].titleOfCH
        let subjectOfCH =
        self.challengAttachmentModelList[indexPath.row].subjectOfCH
//        let numberOfweek =
//        self.challengAttachmentModelList[indexPath.row].numberOfweek
        let numberOfCH =
        self.challengAttachmentModelList[indexPath.row].numberOfCH
        let difficultylevel =
        self.challengAttachmentModelList[indexPath.row].difficultylevel
        cell.challingeId =  self.challengAttachmentModelList[indexPath.row].challengId
      
      
        cell.difficultyOfCh.text = difficultylevel
        cell.numberOfCh.text = numberOfCH
        cell.subjectOfCh.text = subjectOfCH
        cell.titleOfCh.setTitle(titleOfCH, for: .normal)
        cell.btnHeart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        cell.myCellDelegate = self
        return cell
        
        
    }
    
  
}

