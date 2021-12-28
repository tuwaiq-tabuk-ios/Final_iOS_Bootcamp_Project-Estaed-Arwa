//
//  TeacherCourses.swift
//  Estaed
//
//  Created by arwa balawi on 10/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class TeacherCoursesViewController : UIViewController {
  
    @IBOutlet var tableViewCD : UITableView!
    var courses = [CourseDetailsModel]()  /// ???? ()
  var ref: DatabaseReference!
  
    
  override func viewDidLoad() {
    super.viewDidLoad()
      tableViewCD.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
      tableViewCD.delegate = self
      tableViewCD.dataSource = self
      ref = Database.database().reference()
      getCourses()
  }
  
  
    func getCourses()
    {
        self.ref.child("courses").observe(.value) { dataSnapShot in
         
            
    if let data =  dataSnapShot.value as? NSDictionary{
      for (_ , val) in data {
      for (_,v ) in val as! NSDictionary{
      // self.courses.append(Course(courseName: v as! String))

      if let value  = v as? NSDictionary{
      self.courses.append(CourseDetailsModel(
      CourseName: value["CourseName"] as? String ?? "",
      addteachername: value["addteachername"] as? String ?? "",
      addcoursecontents: value["addcoursecontents"] as? String ?? "",
      addcoursetime: value["addcoursetime"] as? String ?? "",
      addcourseprice: value["addcourseprice"] as? String ?? "",
      CourseKind: value["CourseKind"] as? String ?? ""))
                                print("The Course Name : \(v)")
                            }
                           
                        }
                    }
                    
                }else
            {
              Constant.getMsg(title: "Error!", Msg: "error while Getting Data", context: self)

            }
            self.tableViewCD.reloadData()
        }
    }
  
//
//
//  @IBAction func Edit(_ sender: Any) {
//
//
//  }
//
//  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//    if editingStyle == .delete {
//      print("Deleted")
//
//      self.courses.remove(at: indexPath.row)
//      self.tableView.deleteRows(at: [indexPath], with: .automatic)
//    }
//  }
  
}

//MARK:-  2 cell خطوات تفعيل زر بوتون في
//اضيف اسم بروتكول
extension TeacherCoursesViewController : UITableViewDelegate,UITableViewDataSource ,MyCellDelegate
{
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
       let courseName = self.courses[indexPath.row].CourseName
       let courseKind = self.courses[indexPath.row].CourseKind
       let content  = self.courses[indexPath.row].addcoursecontents
        let price = self.courses[indexPath.row].addcourseprice
        let teacherName = self.courses[indexPath.row].addteachername
       let CourseTime  = self.courses[indexPath.row].addcoursetime
      cell?.courseName.text = courseName
      cell?.courseKind.text = courseKind
      cell?.addcoursecontents.text = content
      cell?.addcourseprice.text = price
      cell?.addteachername.text = teacherName
      cell?.addcoursetime.text = CourseTime
//      let coursedetail = CourseDetailsModel(
//        CourseName: courseName,
//        addteachername: teacherName,
//        addcoursecontents: content,
//        addcoursetime: CourseTime,
//        addcourseprice: price,
//        CourseKind: courseKind)
      cell?.btnManageCourse.tag = indexPath.row
      cell?.btnChallenge.tag = indexPath.row
    //  cell?.btnManageCourse.addTarget(self, action: #selector(ManageCourse), for: .touchUpInside)
      //MARK:- 3 cell خطوات تفعيل زر بوتون في
// اسم البروتكول ... خطوه ٣ و ٤ يكونو في فنكشن الصفوف 

      cell?.myCellDelegate = self
      //MARK:- 4 cell خطوات تفعيل زر بوتون في
//اسم البوتون.tage= ...
    //  cell?.btnDetails.tag = indexPath.row
      
      
        return cell!
    }
  
  
  func didPressButton(_ tag : Int)
  {
    let courseDetails = self.courses[tag]
    print("teacherName : \(courseDetails.addteachername)")
    //تأكدت ان المعلومات انتقلت الآن الى هذه الواجهه
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    let Manage = storyboard?.instantiateViewController(identifier: "courseManage") as? CourseManagementViewController
    Manage?.courseDetails = courseDetails
    //تم انتقال المعلومات
    
    let Challenge = storyboard?.instantiateViewController(identifier: "Challenges") as? ChallengesViewController
    Challenge?.modalPresentationStyle = .fullScreen
    self.present(Challenge!, animated: true, completion: nil)
    //تم انتقال المعلومات
  }
  //MARK:-  5 cell خطوات تفعيل زر بوتون في
  //فنكشن اجباريه في البروتكول اللي ضفته بالكلاس
  
//  func didPressButton(_ tag: Int) {
//    print("I have pressed a button with a tag: \(self.courses[tag].courseName)") //  اضيف اسم مودل والمتغير اللي بداخله المتعرفين ب اعلى الكلاس
//        //اي اسم عند name
//        let nextViewController = storyboard?.instantiateViewController(identifier: "Details") as? TeacherCourseDetails // افتح انسبكتور وآخذ آي دي واسم الكلاس اللي ابيه يتوصل مع البوتون ثم نروح لكلاس فنكشن البوتون
//        nextViewController?.modalPresentationStyle = .fullScreen
//        self.present(nextViewController!, animated: true, completion: nil)
//
//  }
  
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.courses.count // عدد صفوف
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1  // قسم واحد
    }
}
