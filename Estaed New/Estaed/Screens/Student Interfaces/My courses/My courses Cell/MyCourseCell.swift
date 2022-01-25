//
//  MyCourseCell.swift
//  Estaed
//
//  Created by arwa balawi on 06/06/1443 AH.
//

import UIKit

class MyCourseCell: UITableViewCell {
  
  @IBOutlet weak var courseName: UILabel!
  @IBOutlet weak var courseTimeKind: UILabel!  
  @IBOutlet weak var lecturBtn: UIButton!
    @IBOutlet weak var challingBtn: UIButton!
  
    var cellDelegete : MyCellDelegate!
  
  
  override func awakeFromNib() {
      super.awakeFromNib()
     
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

  }
  
  
  @IBAction func LecturBtn(_ sender: UIButton) {
    cellDelegete.didPressButton(sender.tag)
  }
  
    @IBAction func challengeBtnTapped(_ sender: UIButton) {
        cellDelegete.didPressButton(sender.tag)
    }
    
}
