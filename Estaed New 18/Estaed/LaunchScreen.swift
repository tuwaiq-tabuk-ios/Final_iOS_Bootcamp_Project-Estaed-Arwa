//
//  LaunchScreen.swift
//  Estaed
//
//  Created by arwa balawi on 11/06/1443 AH.
//

import Foundation
import UIKit

class LaunchScreenViewController: UIViewController {
  
  private let imageView: UIImageView = {
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
    imageView.image = UIImage(named: "logo")
    return imageView }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(imageView)
    view.backgroundColor = .link
  }
  
  override func viewDidLayoutSubviews () {
    super.viewDidLayoutSubviews()
    imageView.center = view.center
}
}
