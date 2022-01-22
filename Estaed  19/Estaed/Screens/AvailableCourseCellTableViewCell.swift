//
//  AvailableCourseCellTableViewCell.swift
//  Estaed
//
//  Created by arwa balawi on 18/06/1443 AH.
//

import UIKit

class AvailableCourseCellTableViewCell: UITableViewCell {

  @IBOutlet weak var courseName: UILabel!
  
  @IBOutlet weak var coursePrise: UILabel!
  
  @IBOutlet weak var courseKind: UILabel!
  
  
  @IBAction func detailBtn(_ sender: Any) {
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  func configre(value : CourseModel?)
  {
    if value != nil
    {
      courseName.text = value?.courseName
      courseKind.text = value?.courseTimeKind
      coursePrise.text = value?.coursePrice
    }
  }
}
