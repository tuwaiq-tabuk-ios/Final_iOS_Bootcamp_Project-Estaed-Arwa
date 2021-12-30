//
//  TableViewCell.swift
//  Estaed
//
//  Created by arwa balawi on 11/05/1443 AH.
//

import UIKit
import Foundation

class TableViewCell: UITableViewCell {

  @IBOutlet var btnManageCourse : UIButton!
  @IBOutlet var btnChallenge: UIButton!
  
   @IBOutlet var courseName : UILabel!
    @IBOutlet var addteachername : UILabel!
    @IBOutlet var addcoursecontents : UILabel!
    @IBOutlet var addcoursetime : UILabel!
    @IBOutlet var addcourseprice : UILabel!
    @IBOutlet  var courseKind : UILabel!
//    @IBOutlet var btnDetails : UIButton!
  
  //MARK:-  6 cell خطوات تفعيل زر بوتون في
//اعرف متغير من نوع بروتكول
  
  var myCellDelegate : MyCellDelegate?
  
  @IBAction func btnUpdateCourse(_ Sender : UIButton)
  {
    myCellDelegate?.didPressButton(Sender.tag)
  }
  
  @IBAction func btnChallenge(_ Sender: UIButton)
  {
    myCellDelegate?.didPressButton(Sender.tag)
  }
  //MARK:- last step 7 cell خطوات تفعيل زر بوتون في
  //اسوي فنكشن لزر البوتون من نوع UIButton وبداخله اسم البروتكول ؟. ثابت (انا اكتبه)
  
//  @IBAction func btnDetails(_ sender: UIButton) {
//
//    myCellDelegate?.didPressButton(sender.tag)
//
//  }

  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}

