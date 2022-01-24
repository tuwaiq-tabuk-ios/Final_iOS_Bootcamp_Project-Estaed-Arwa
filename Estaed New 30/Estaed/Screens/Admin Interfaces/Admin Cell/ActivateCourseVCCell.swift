//
//  ActivateCourseVCCell.swift
//  Estaed
//
//  Created by arwa balawi on 30/05/1443 AH.


import UIKit
import FirebaseDatabase
class ActivateCourseVCCell: UITableViewCell {
  
  
  @IBOutlet weak var studentIdCell: UILabel!
  @IBOutlet weak var courseIdCell: UILabel!
  @IBOutlet weak var PaidBtn: UIButton!
  
    var model =  StudentCourseModel()
  
  @IBAction func paidBtn(_ sender: Any) {
   // self.paidBtn = true
      model.isPaid = true
      Database.database().reference().child("StudentCourses").child(model.StudentId).child(model.courseId).setValue(model.toDic())
    PaidBtn.backgroundColor = UIColor.init(red: 11/255, green: 70/255, blue: 25/255, alpha: 1)
    
  }
  
  
  
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
