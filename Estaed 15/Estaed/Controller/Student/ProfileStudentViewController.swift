//
//  ProfileStudent.swift
//  Estaed
//
//  Created by arwa balawi on 21/05/1443 AH.
//

import Foundation
import UIKit

class ProfileStudentViewController : UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBAction func logOutButtonTapped(_ sender: Any) {
   
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // To make Circle Image
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = imageView.frame.height / 2
  }
  
}
