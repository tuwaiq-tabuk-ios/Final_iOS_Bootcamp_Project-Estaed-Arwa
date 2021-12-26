//
//  CourseManagementViewController.swift
//  Estaed
//
//  Created by arwa balawi on 21/05/1443 AH.
//

import UIKit
import FirebaseDatabase
class CourseManagementViewController: UIViewController {

  var courseDetails : CourseDetailsModel!
  var ref:DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()

      print("Welocome To Managment Class Teacher Name Is : \(courseDetails.addteachername)")
      
      
//      /to delete button
     
      let db = FirebaseDatabase.Database.database()

      ref = db.reference().child("courses").child("Qudrat").child("Normal")
      ref.removeValue()
      //end of delete button
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
