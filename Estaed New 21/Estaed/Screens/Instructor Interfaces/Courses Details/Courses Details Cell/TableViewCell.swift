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
  @IBOutlet weak var btnLectures: UIButton!
  @IBOutlet var courseName : UILabel!
  @IBOutlet var courseContents : UILabel!
  @IBOutlet var courseTime : UILabel!
  @IBOutlet var coursePrice : UILabel!
  @IBOutlet  var courseTimeKind : UILabel!
  
 
 
  
  
  var myCellDelegate : MyCellDelegate?
  
  @IBAction func btnUpdateCourse(_ Sender : UIButton)
  {
    myCellDelegate?.didPressButton(Sender.tag)
  }
  
  @IBAction func btnChallenge(_ Sender: UIButton)
  {
    myCellDelegate?.didPressButton(Sender.tag)
  }
  
  @IBAction func btnLectures(_ Sender: UIButton)
  {
  myCellDelegate?.didPressButton(Sender.tag)
    
  }
  
  
  
  
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  
}

