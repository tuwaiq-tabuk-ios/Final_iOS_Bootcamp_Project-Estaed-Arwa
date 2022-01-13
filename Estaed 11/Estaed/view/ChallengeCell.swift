//
//  ChallengeCell.swift
//  Estaed
//
//  Created by arwa balawi on 02/06/1443 AH.
//

import UIKit

class ChallengeCell: UITableViewCell {
  

  var numberOfChallengeLabel: UILabel = {
    let label = UILabel(frame: CGRect(x: 10, y: 10, width: 200, height: 25))
    label.text = "Number Of Challenge:-"
    return label
  }()

  var numberOfChallenge: UILabel = {
    let label = UILabel(frame: CGRect(x: 10, y: 30, width: 70, height: 25))

    return label
  }()

  var subjectOfChallengLabel : UILabel = {
    let label = UILabel(frame: CGRect(x: 10, y: 60, width: 200, height: 25))
    label.text = "Subject of challeng:-"
    return label
  }()

    var subjectOfChalleng: UILabel = {
      let label = UILabel(frame: CGRect(x: 10, y: 80, width: 100, height: 25))

      return label
    }()

  var numberOfWeekLabel :UILabel = {
   let label = UILabel(frame: CGRect(x: 10, y: 110, width: 200 , height:25 ))
    label.text = "number of week:-"
    return label
  }()
     var numberOfWeek: UILabel = {
      let label = UILabel(frame: CGRect(x: 10, y: 130, width: 120, height: 25))

      return label
    }()

  var titleOfChallengeLabel : UILabel = {
    let label = UILabel(frame: CGRect(x: 230, y: 10, width: 200, height: 25))
    label.text = "title of challenge:-"
    return label
  }()

     var titleOfChallenge: UILabel  = {
  let label = UILabel(frame: CGRect(x: 230, y: 30, width: 200, height: 25))

  return label
}()
  var difficultyLevelLabel : UILabel = {
   let label = UILabel(frame: CGRect(x: 230, y: 60, width: 200, height: 25))
    label.text = "difficulty Level:-"
    return label
  }()

     var difficultyLevel: UILabel = {
      let label = UILabel(frame: CGRect(x: 230, y: 80, width: 50, height: 25))

      return label
    }()
    var BtnChallengDetails: UIButton = {
      let btn = UIButton(frame: CGRect(x: 210, y: 110, width: 50, height: 25))
      btn.target(forAction: #selector(BtnChallengDetails(_:)), withSender: UIButton.self)
      return btn
    }()


    var myCellDelegate : MyCellDelegate?


    @objc func BtnChallengDetails(_ Sender : UIButton)
    {
      print("I'm Pressed tag = \(Sender.tag)")
      myCellDelegate?.didPressButton(Sender.tag)

    }

  func initCell(model : ChallengAttachmentModel)
  {
    self.contentView.addSubview(numberOfChallengeLabel)
    self.contentView.addSubview(numberOfChallenge)
    self.contentView.addSubview(numberOfWeekLabel)
    self.contentView.addSubview(numberOfWeek)
    self.contentView.addSubview(difficultyLevelLabel)
    self.contentView.addSubview(difficultyLevel)
    self.contentView.addSubview(subjectOfChallengLabel)
    self.contentView.addSubview(subjectOfChalleng)
    self.contentView.addSubview(titleOfChallengeLabel)
    self.contentView.addSubview(titleOfChallenge)
    self.contentView.addSubview(BtnChallengDetails)

    self.numberOfChallenge.text = model.numberOfCH
    self.numberOfWeek.text = model.numberOfweek
    self.difficultyLevel.text = model.difficultylevel
    self.subjectOfChalleng.text = model.subjectOfCH
    self.titleOfChallenge.text = model.titleOfCH
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
