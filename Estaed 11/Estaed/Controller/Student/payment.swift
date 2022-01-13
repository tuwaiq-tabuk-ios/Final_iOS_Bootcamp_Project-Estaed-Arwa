//
//  payment.swift
//  Estaed
//
//  Created by arwa balawi on 20/05/1443 AH.
//

import Foundation
import UIKit

class payment : UIViewController{
  
  @IBOutlet weak var ThankLabel: UILabel!
  @IBOutlet weak var Check: UILabel!
  @IBAction func Done(_ sender: Any) {
    
  
    Check.text = "Your request has been successfully received. The request will be reviewed and confirmed within 12 hours"

    ThankLabel.text = "Thank for trusting us "

  }
  
  override func viewDidLoad() {
  }
  
}
