//
//  TableVCChallenges.swift
//  Estaed
//
//  Created by arwa balawi on 23/05/1443 AH.


import UIKit
import FirebaseDatabase

class TableVCChallengesCell: UITableViewCell {

  
  @IBOutlet weak var numberOfChallenge: UILabel!
  @IBOutlet weak var subjectOfChalleng: UILabel!
  @IBOutlet weak var numberOfWeek: UILabel!
  @IBOutlet weak var titleOfChallenge: UILabel!
  @IBOutlet weak var difficultyLevel: UILabel!
  @IBOutlet weak var BtnChallengDetails: UIButton!
  
  
  var myCellDelegate : MyCellDelegate?
  
  
  @IBAction func BtnChallengDetails(_ Sender : UIButton)
  {
    print("I'm Pressed tag = \(Sender.tag)")
    myCellDelegate?.didPressButton(Sender.tag)
   
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
