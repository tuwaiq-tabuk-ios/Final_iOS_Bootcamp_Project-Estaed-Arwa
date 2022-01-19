//
//  myCallengesCell.swift
//  Estaed
//
//  Created by arwa balawi on 06/06/1443 AH.
//

import UIKit
import Firebase
class myCallengesAttachmentCell: UITableViewCell {
  
  @IBOutlet weak var numberOfCh: UILabel!
  @IBOutlet weak var titleOfCh: UILabel!
  @IBOutlet weak var completed: UILabel!
  @IBOutlet weak var subjectOfCh: UILabel!
  @IBOutlet weak var difficultyOfCh: UILabel!
  
  @IBAction func NextPage(_ sender: Any) {
//    let myCallengesAttachmentCell = self.storyboard?
//      .instantiateViewController(identifier:Constant.storyboard.StudentDetailsChallengeVC )
//       
//       self.view.window?.rootViewController = myCallengesAttachmentCell
//       self.view.window?.makeKeyAndVisible()
  }
  var challingeId = ""
  
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
      ref.child(Constant.StudentId).child(challingeId).setValue([
        "challingeId" : challingeId,
        "StudentId" : Constant.StudentId,
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
      ref.child(Constant.StudentId).child(challingeId).removeValue()
      sender.tag = 10
      sender.setImage(UIImage(systemName: "heart"), for: .normal)
      
    }
  }
  
}
