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
    
    tableViewCH.register(UINib(nibName: "TableVCChallenges", bundle: nil), forCellReuseIdentifier: "myCell")
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
    
    let cell = tableView.dequeueReusableCell(withIdentifier:
                                              "myCell",
                                             for: indexPath) as? TableVCChallengesCell
    
    
    let titleOfCH = self.ChallengAttachmentModelList[indexPath.row].titleOfCH
    let subjectOfCH =
      self.ChallengAttachmentModelList[indexPath.row].subjectOfCH
    let numberOfweek =
      self.ChallengAttachmentModelList[indexPath.row].numberOfweek
    let numberOfCH =
      self.ChallengAttachmentModelList[indexPath.row].numberOfCH
    let difficultylevel =
      self.ChallengAttachmentModelList[indexPath.row].difficultylevel
    cell?.difficultyLevel.text = difficultylevel
    cell?.numberOfChallenge.text = numberOfCH
    cell?.numberOfWeek.text = numberOfweek
    cell?.subjectOfChalleng.text = subjectOfCH
    cell?.titleOfChallenge.text = titleOfCH
    cell?.BtnChallengDetails.tag = indexPath.row
      cell?.myCellDelegate = self
    return cell!
    
  }
  
  
  
  
  
  
}


























// لعمل تيبل اختار فيو كنترولر ثم ادخل فيه تيبل الآن بنشأ له ملف من نوع coca من الملفات ثم نوع سيل وانشأ ملف  xib
//ادخل هنا احط مكتبه الفاير بيس بما اني بشتغل عليها ثم اسوي مودل لكل البيانات اللي ابيها تتسجل بالداتا بيس واعرفها داخل متغير + اذكر نوع الريف

//ادخل بداله الفيو لوود احتاج بداخله اسم التيبل فيو و تعريف الكلاس المرتبط بالسل ثم الديليقيت والسورك (دالتين اجباريه) ثم اعرف الريف
//استدعي داله قيت داتا اللي راح تسجل البيانات داخل الفايربيس
//الان اروح عند الدوال الاجباريه حقت الداتا سورك واحطهم داخل اكستنشن لترتيب الكود بس قبلها احذف البروتكول التلقائي اللي عند الكلاس واحطهم داخل الاكستشن
//الداله اللي ترجع عدد الصفوف هي اللي احط لها ارجاع الكاونت حق المتغير اللي معرفه داخله المودل اما الداله الاجباريه الثانيه احط بداخلها محتوى كل سل وهي اللي لها كلام كثير غالبا


/**
 
 
 var ChallengAttID = ""
 var numberOfCH = ""
 var titleOfCH = ""
 var numberOfweek = ""
 var difficultylevel = ""
 var subjectOfCH = ""
 
 for (_,_) in data!
 {
 for (_,_) in data!
 {
 for (_,_) in data!
 {
 for (_,v) in data!
 {
 for (_, value) in v as! NSDictionary
 {
 let v1 = value as! NSDictionary
 let v2 = v1["CourseKind"] as! NSDictionary
 for (key ,val) in v2
 {
 let val2 = val as! NSDictionary
 ChallengAttID = val2["ChallengAttID"] as! String
 
 numberOfCH = val2["Number Of Challeng"] as! String
 
 titleOfCH = val2["title Of Challeng"] as! String
 
 numberOfweek = val2["Number Of Week"] as! String
 
 difficultylevel = val2["difficulty Level"] as! String
 
 subjectOfCH = val2["subject Of Challeng"] as! String
 
 self.ChallengAttachmentModelList.append(ChallengAttachmentModel(ChallengAttID: ChallengAttID, numberOfCH: numberOfCH, titleOfCH: titleOfCH, numberOfweek: numberOfweek, difficultylevel: difficultylevel, subjectOfCH: subjectOfCH))
 }
 }
 }
 
 
 }
 }
 }
 }
 
 self.tableViewCH.reloadData()
 }
 
 )}
 
 */
