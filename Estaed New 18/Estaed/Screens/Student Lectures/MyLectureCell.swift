//
//  MyLectureCell.swift
//  Estaed
//
//  Created by arwa balawi on 06/06/1443 AH.
//

import UIKit

class MyLectureCell: UITableViewCell {

  @IBOutlet weak var lectureName: UILabel!
  @IBOutlet weak var lectureDate: UILabel!
  @IBOutlet weak var lectureTime: UILabel!
  @IBOutlet weak var joinBtn: UIButton!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var url : String = ""
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func joinBtnTapped(_ sender: Any) {
        if !url.isEmpty
        {
            let Myurl = URL(string:url)!
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(Myurl, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(Myurl)
            }
        }
     
    }
}
