//
//  ChallengesViewController.swift
//  Estaed
//
//  Created by arwa balawi on 23/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class ChallengesTableViewController: UIViewController {

  var Challenges = [ChallengAttachmentModel]()
  var ref: DatabaseReference!

  @IBOutlet weak var tableViewCH: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()

      tableViewCH.register(UINib(nibName: "TableVCChallenges", bundle: nil), forCellReuseIdentifier: "TableVCChallenges")
      tableViewCH.delegate = self
      tableViewCH.dataSource = self
      ref = Database.database().reference()
//      getData()
    }



}

extension ChallengesTableViewController : UITableViewDelegate,UITableViewDataSource {


  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.Challenges.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableVCChallenges", for: indexPath) as? TableVCChallenges
    let titleOfCH = self.Challenges[indexPath.row].titleOfCH
    let subjectOfCH =
    self.Challenges[indexPath.row].subjectOfCH
    let quistiontOfCH =
    self.Challenges[indexPath.row].quistiontOfCH
    let numberOfweek =
    self.Challenges[indexPath.row].numberOfweek
    let numberOfCH =
    self.Challenges[indexPath.row].numberOfCH
    let difficultylevel =
    self.Challenges[indexPath.row].difficultylevel
    let correctAnswer =
    self.Challenges[indexPath.row].correctAnswer
    let answersD =
    self.Challenges[indexPath.row].answersD
    let answersC =
    self.Challenges[indexPath.row].answersC
    let answersA =
    self.Challenges[indexPath.row].answersA
    let answerB =
    self.Challenges[indexPath.row].answerB


  }



//
//  cell?.courseName.text = courseName
//  cell?.courseKind.text = courseKind
//  cell?.addcoursecontents.text = content
//  cell?.addcourseprice.text = price
//  cell?.addteachername.text = teacherName
//  cell?.addcoursetime.text = CourseTime
//  }
//
//

































// لعمل تيبل اختار فيو كنترولر ثم ادخل فيه تيبل الآن بنشأ له ملف من نوع coca من الملفات ثم نوع سيل وانشأ ملف  xib
//ادخل هنا احط مكتبه الفاير بيس بما اني بشتغل عليها ثم اسوي مودل لكل البيانات اللي ابيها تتسجل بالداتا بيس واعرفها داخل متغير + اذكر نوع الريف

//ادخل بداله الفيو لوود احتاج بداخله اسم التيبل فيو و تعريف الكلاس المرتبط بالسل ثم الديليقيت والسورك (دالتين اجباريه) ثم اعرف الريف
  //استدعي داله قيت داتا اللي راح تسجل البيانات داخل الفايربيس
//الان اروح عند الدوال الاجباريه حقت الداتا سورك واحطهم داخل اكستنشن لترتيب الكود بس قبلها احذف البروتكول التلقائي اللي عند الكلاس واحطهم داخل الاكستشن
//الداله اللي ترجع عدد الصفوف هي اللي احط لها ارجاع الكاونت حق المتغير اللي معرفه داخله المودل اما الداله الاجباريه الثانيه احط بداخلها محتوى كل سل وهي اللي لها كلام كثير غالبا
}
