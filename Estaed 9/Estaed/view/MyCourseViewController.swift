//
//  MyCourseViewController.swift
//  Estaed
//
//  Created by arwa balawi on 02/06/1443 AH.
//

//import UIKit
//import FirebaseDatabase
//
//class MyCourseViewController: UIViewController {
//
//  @IBOutlet weak var tableViewMyCourse: UITableView!
//
//  var ref : DatabaseReference!
//  var CourseModelList = [StudentCourseModel]()
//  var paidCourses = [StudentCourseModel]()
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    tableViewMyCourse.register(UINib(nibName: "MyCourseCell", bundle: nil), forCellReuseIdentifier: "MyCourseCell")
//    tableViewMyCourse.delegate = self
//    tableViewMyCourse.dataSource = self
//    ref = Database.database().reference()
//
//    getdata()
//  }
//
//  func getdata()
//  {
//    if !self.CourseModelList.isEmpty
//    {
//      self.CourseModelList.removeAll()
//    }
//    print("userId : " + Constant.StudentId)
//    self.ref.child("StudentCourses").child(Constant.StudentId).getData(completion: { error, dataSnapShot in
//
//
//    })
//
//
//  }
//}
//
//    }
//  }
//
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//      return self.CourseModelList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//      let cell = tableView.dequeueReusableCell(withIdentifier: "MyCourseCell", for: indexPath) as? MyCourseCell
//      ref.child("courses").child(Constant.userId).child(self.CourseModelList[indexPath.row].courseId).getData { error, Data in
//        if let data = Data.value as? NSDictionary{
//          let course = CourseModel(value: data)
//          cell!.courseName.text = course.courseName
//          cell?.LecturBtn.tag = indexPath.row
//          cell?.cellDelegete = self
//          cell!.courseTimeKind.text = course.courseTimeKind
//        }
//      }
//
//    return cell!
//
//  }
//
//
//
//}
//
//
//
//
//
//
//
