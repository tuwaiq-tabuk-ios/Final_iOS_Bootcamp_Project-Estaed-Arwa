//
//  StudentChallengeViewController.swift
//  Estaed
//
//  Created by arwa balawi on 01/06/1443 AH.
//

import UIKit
import Firebase

class StudentChallengAttachmentVC: UIViewController , UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
  
  @IBOutlet weak var progress: UIProgressView!
  @IBOutlet weak var difficutlyTextFilde: UITextField!
  
  var model = ChallengAttachmentModel()
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    var diffList = ["All","Easy","Medium","Hard"]
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return diffList.count
    }
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func closePicker() {
        view.endEditing(true)
      
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        self.difficutlyTextFilde.text = self.diffList[row]
    }
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String?{
        
        return self.diffList[row]
    }
    @IBOutlet weak var tableViewStudentCH: UITableView!
    let toolBar = UIToolbar()
    
    var ChallengAttachmentModelList = [ChallengAttachmentModel]()
    var ref: DatabaseReference!
    var refreshControl = UIRefreshControl()
    var transferedCId = ""
  
    let piker = UIPickerView()
    var  easyQuestion = [ChallengAttachmentModel]()
    var  meduimQuestion = [ChallengAttachmentModel]()
    var  hardQuestion = [ChallengAttachmentModel]()
    var diff = false
    var diffText = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
        piker.delegate = self
        piker.dataSource = self
        difficutlyTextFilde.delegate = self
        difficutlyTextFilde.inputView = piker
        difficutlyTextFilde.inputAccessoryView = toolBar
        toolBar.sizeToFit()
        let btnDone = UIBarButtonItem(title:"Done".localized,
                                      style: .plain ,
                                      target: self ,
                                      action: #selector(closePicker))
      
        toolBar.setItems([btnDone],
                         animated: true)
      
        tableViewStudentCH.register(UINib(nibName: "myCallengesAttachmentCell",
                                                   bundle: nil),
                                                   forCellReuseIdentifier: "myCell")
        tableViewStudentCH.delegate = self
        tableViewStudentCH.dataSource = self
        ref = Database.database().reference()
        getData()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      
        difficutlyTextFilde.resignFirstResponder()
        print("finshed Editing".localized)
        diff = true
        diffText = textField.text!
        self.tableViewStudentCH.reloadData()
        
    }
//    @objc func getDataOfWeakNumber() {
//        arrSection.append(NumberOfWeekModel(arrNumberOfWeek: ["first week","second week","third week","fourth week","fifth week","sixth week","Seventh week","eighth week", "ninth week" ,"tenth week","eleventh week","Twelfth week"]
//
//                                            , arrNumberOfWeek2: ["first week","second week","third week","fourth week","fifth week","sixth week"]))
//        refreshControl.endRefreshing()
//        tableViewStudentCH.reloadData()
//
//
//
//    }
    
    func getData()
    {
        print("get Challenge Data start")
      print("chall : \(K.RealtimeDatabase.challenge)")
        print("courseId : \(transferedCId)")
      
        if !self.ChallengAttachmentModelList.isEmpty
        {
            self.ChallengAttachmentModelList.removeAll()
        }
        if !self.hardQuestion.isEmpty
        {
            self.hardQuestion.removeAll()
        }
        if !self.meduimQuestion.isEmpty
        {
            self.meduimQuestion.removeAll()
        }
        if !self.easyQuestion.isEmpty
        {
            self.easyQuestion.removeAll()
        }
      ref.child(K.RealtimeDatabase.challenge).child(self.transferedCId).getData(completion: { error, Data in
            if let data = Data.value as? NSDictionary ,Data.exists(){
                for (_,v0) in data {
                  
                        
                        let value = v0 as! NSDictionary
                        let myModel = ChallengAttachmentModel(value: value)
                        if myModel.courseId == self.transferedCId
                        {
                            self.ChallengAttachmentModelList.append(myModel)
                            if myModel.difficultylevel == "Hard"
                            {
                                self.hardQuestion.append(myModel)
                            }else if myModel.difficultylevel == "Medium" {
                                self.meduimQuestion.append(myModel)
                            }else{
                                self.easyQuestion.append(myModel)
                            }
                        }
                        
                   
                }
            }
            
            
            if !self.ChallengAttachmentModelList.isEmpty
            {
                var CompletedCount = 0
                for index in self.ChallengAttachmentModelList
                {
                    if index.isCompLeted
                    {
                        CompletedCount += 1
                    }
                }
                let progress = Float(CompletedCount / self.ChallengAttachmentModelList.count)
                print("progress : \(progress)")
                self.progress.progress = progress
                
            }
            self.tableViewStudentCH.reloadData()
            
        }
        )}
    
}

extension StudentChallengAttachmentVC : UITableViewDelegate,UITableViewDataSource,MyCellDelegate {
 
    func didPressButton(_ tag: Int) {
        if let next = self.storyboard?
            .instantiateViewController(identifier:K.Storyboard.studentDetailsChallengeVC ) as? StudentDetailsChallengeVC
        {
            next.ChallingeId = model.challengId
            next.modelAttatch = model
            next.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(next, animated: false)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if diff
        {
            if diffText == "Easy"
            {
                return self.easyQuestion.count
            }else if diffText == "Medium"
            {
                return self.meduimQuestion.count
            }else if diffText == "Hard"
            {
                
                return self.hardQuestion.count
            }else
            {
                return self.ChallengAttachmentModelList.count
            }
            
        }else
        {
            return self.ChallengAttachmentModelList.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = tableView.dequeue() as! TableChallengeCell
        guard  let cell = tableView.dequeueReusableCell(withIdentifier:"myCell",
                                                        for: indexPath) as? MyCallengesAttachmentCell else{
            print("error in returning Cell".localized)
            return UITableViewCell()
        }
        
        print("diff = \(diff)   diffText : \(diffText)")
        if diff
        {
            if diffText == "Easy"
            {
                model = self.easyQuestion[indexPath.row]
            }else if diffText == "Medium"
            {
                model = self.meduimQuestion[indexPath.row]
            }else if diffText == "Hard"
            {
                
                model = self.hardQuestion[indexPath.row]
            }else if diffText == "All"
            {
                model = self.ChallengAttachmentModelList[indexPath.row]
            }
            
        }else
        {
            model = self.ChallengAttachmentModelList[indexPath.row]
        }
        
        
      ref.child("Favorite").child(K.RealtimeDatabase.studentId).child(model.challengId).getData { Error, Data in
            if Data.exists(){
                cell.btnHeart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }else
            {
                cell.btnHeart.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
        cell.accessoryType = model.isCompLeted ? .checkmark : .none
        cell.challingeId =  model.challengId
        cell.numOfWeekLabel.text = model.numberOfweek
        cell.difficultyOfCh.text = model.difficultylevel
        cell.numberOfCh.text =  model.numberOfCH
        cell.subjectOfCh.text =  model.subjectOfCH
        cell.titleOfCh.setTitle(model.titleOfCH, for: .normal)
        cell.myCellDelegate = self
        return cell
        
    }

}

