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
  @IBOutlet weak var LecturBtn: UIButton!

  var cellDelegete : MyCellDelegate!
  
  @IBAction func LecturBtn(_ sender: UIButton) {
    cellDelegete.didPressButton(sender.tag)
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
