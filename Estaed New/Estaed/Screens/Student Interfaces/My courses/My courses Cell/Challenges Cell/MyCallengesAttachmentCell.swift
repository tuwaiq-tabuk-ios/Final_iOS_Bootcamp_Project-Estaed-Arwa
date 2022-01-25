//
//  myCallengesCell.swift
//  Estaed
//
//  Created by arwa balawi on 06/06/1443 AH.
//

import UIKit
import Firebase
class MyCallengesAttachmentCell: UITableViewCell {
  
  @IBOutlet weak var numOfWeekLabel: UILabel!
  @IBOutlet weak var numberOfCh: UILabel!
  @IBOutlet weak var titleOfCh: UIButton!
  @IBOutlet weak var completed: UILabel!
  @IBOutlet weak var subjectOfCh: UILabel!
  @IBOutlet weak var difficultyOfCh: UILabel!
  @IBOutlet weak var btnHeart : UIButton!
  @IBOutlet weak var btnDetails: UIButton!
  
  var challingeId = ""
  var myCellDelegate : MyCellDelegate?
  
  @IBAction func didbtnTapped(_ sender: UIButton) {
      myCellDelegate?.didPressButton(sender.tag)
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
    }

  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

  
    
  @IBAction func btnHeartTapped(_ sender : UIButton)
  {
    let ref = Database.database().reference().child("Favorite")
    if sender.tag == 10
    {
      ref.child(K.RealtimeDatabase.studentId).child(challingeId).setValue([
        "challingeId" : challingeId,
        "StudentId" : K.RealtimeDatabase.studentId ,
        "isCompLeted" : false
      ]){ error , Data in
        if error == nil
        {
          sender.tag = 100
          sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
          
        }
        
      }
    }else
    {
      ref.child(K.RealtimeDatabase.studentId).child(challingeId).removeValue()
      sender.tag = 10
      sender.setImage(UIImage(systemName: "heart"), for: .normal)
      
    }
  }
  
}
