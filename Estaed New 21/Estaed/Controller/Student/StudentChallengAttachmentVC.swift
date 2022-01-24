//
//  StudentChallengeViewController.swift
//  Estaed
//
//  Created by arwa balawi on 01/06/1443 AH.
//

import UIKit
import Firebase

class StudentChallengAttachmentVC: UIViewController , UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    var diffList = ["All","Easy","Medium","Hard"]
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return diffList.count
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func closePicker() {
        //   SelectNumberOfCh.text = arrNumberOfCh[currentIndex]
        view.endEditing(true)
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.DifficutlyTextFilde.text = self.diffList[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        return self.diffList[row]
    }
    @IBOutlet weak var tableViewStudentCH: UITableView!
    let toolBar = UIToolbar()
    
    
    @IBOutlet weak var progress: UIProgressView!
    
    
    
    
    
    
    var model = ChallengAttachmentModel()
    @IBOutlet weak var DifficutlyTextFilde: UITextField!
    var ChallengAttachmentModelList = [ChallengAttachmentModel]()
    var arrSection = [NumberOfWeekModel]()
    var ref: DatabaseReference!
    var refreshControl = UIRefreshControl()
    var TransferedCId = ""
    let piker = UIPickerView()
    var  easyQuestion = [ChallengAttachmentModel]()
    var  MeduimQuestion = [ChallengAttachmentModel]()
    var  hardQuestion = [ChallengAttachmentModel]()
    var diff = false
    var diffText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        piker.delegate = self
        piker.dataSource = self
        DifficutlyTextFilde.delegate = self
        DifficutlyTextFilde.inputView = piker
        DifficutlyTextFilde.inputAccessoryView = toolBar
        toolBar.sizeToFit()
        let btnDone = UIBarButtonItem(title:"Done".localized, style: .plain , target: self , action: #selector(closePicker))
        toolBar.setItems([btnDone], animated: true)
        tableViewStudentCH.register(UINib(nibName: "myCallengesAttachmentCell", bundle: nil), forCellReuseIdentifier: "myCell")
        tableViewStudentCH.delegate = self
        tableViewStudentCH.dataSource = self
        ref = Database.database().reference()
        getData()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        DifficutlyTextFilde.resignFirstResponder()
        print("finshed Editing".localized)
        diff = true
        diffText = textField.text!
        self.tableViewStudentCH.reloadData()
        
    }
    @objc func getDataOfWeakNumber() {
        arrSection.append(NumberOfWeekModel(arrNumberOfWeek: ["first week","second week","third week","fourth week","fifth week","sixth week","Seventh week","eighth week", "ninth week" ,"tenth week","eleventh week","Twelfth week"]
                                            
                                            , arrNumberOfWeek2: ["first week","second week","third week","fourth week","fifth week","sixth week"]))
        refreshControl.endRefreshing()
        tableViewStudentCH.reloadData()
        
        
        
    }
    
    func getData()
    {
        print("get Challenge Data start")
        print("chall : \(Constant.challenge)")
        print("courseId : \(TransferedCId)")
        ref.child(Constant.challenge).getData(completion: { error, Data in
            
            if !self.ChallengAttachmentModelList.isEmpty
            {
                self.ChallengAttachmentModelList.removeAll()
            }
            
            if let data = Data.value as? NSDictionary ,Data.exists(){
                for (_,v0) in data {
                    for (_,v) in v0 as! NSDictionary {
                        for (_,v2) in v as! NSDictionary{
                        let value = v2 as! NSDictionary
                        let model = ChallengAttachmentModel(value: value)
                        if model.courseId == self.TransferedCId
                        {
                            self.ChallengAttachmentModelList.append(model)
                            if model.difficultylevel == "Hard"
                            {
                                self.hardQuestion.append(model)
                            }else if model.difficultylevel == "Medium" {
                                self.MeduimQuestion.append(model)
                            }else{
                                self.easyQuestion.append(model)
                            }
                        }
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
            .instantiateViewController(identifier:Constant.storyboard.StudentDetailsChallengeVC ) as? StudentDetailsChallengeVC
        {
            next.ChallingeId = model.ChallengId
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
                return self.MeduimQuestion.count
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
        guard  let cell = tableView.dequeueReusableCell(withIdentifier:
                                                            "myCell",
                                                        for: indexPath) as? myCallengesAttachmentCell else{
            print("error in returning Cell".localized)
            return UITableViewCell()
        }
        
        
        if diff
        {
            if diffText == "Easy"
            {
                model = self.easyQuestion[indexPath.row]
            }else if diffText == "Medium"
            {
                model = self.MeduimQuestion[indexPath.row]
            }else if diffText == "Hard"
            {
                
                model = self.hardQuestion[indexPath.row]
            }else
            {
                model = self.ChallengAttachmentModelList[indexPath.row]
            }
            
        }else
        {
            model = self.ChallengAttachmentModelList[indexPath.row]
        }
        
        
        ref.child("Favorite").child(Constant.StudentId).child(model.ChallengId).getData { Error, Data in
            if let data = Data.value , Data.exists(){
                cell.btnHeart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }else
            {
                cell.btnHeart.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
        let titleOfCH = model.titleOfCH
        let subjectOfCH =
        model.subjectOfCH
        let numberOfweek =
        model.numberOfweek
        let numberOfCH =
        model.numberOfCH
        cell.accessoryType = model.isCompLeted ? .checkmark : .none
        let difficultylevel =
        model.difficultylevel
        cell.challingeId =  model.ChallengId
        cell.numOfWeekLabel.text = numberOfweek
        cell.difficultyOfCh.text = difficultylevel
        cell.numberOfCh.text = numberOfCH
        cell.subjectOfCh.text = subjectOfCH
        cell.titleOfCh.setTitle(titleOfCH, for: .normal)
        cell.myCellDelegate = self
        return cell
        
    }
    
    
//    @objc func navigateToQuestion()
//    {
//        let story = UIStoryboard(name: "Main", bundle: nil)
//        if let next = story.instantiateViewController(withIdentifier: "StudentDetailsChallengeVC") as? StudentDetailsChallengeVC{
//            next.ChallingeId = model.ChallengId
//            next.modelAttatch = model
//            next.modalPresentationStyle = .fullScreen
//            self.present(next, animated: true, completion: nil)
//        }
//    }
    
}

