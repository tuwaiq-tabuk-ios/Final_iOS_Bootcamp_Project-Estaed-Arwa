//
//  myCallengesCell.swift
//  Estaed
//
//  Created by arwa balawi on 06/06/1443 AH.
//

import UIKit

class myCallengesAttachmentCell: UITableViewCell {
  
  @IBOutlet weak var numberOfCh: UILabel!
  @IBOutlet weak var titleOfCh: UILabel!
  @IBOutlet weak var completed: UILabel!
  @IBOutlet weak var subjectOfCh: UILabel!
  @IBOutlet weak var difficultyOfCh: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
