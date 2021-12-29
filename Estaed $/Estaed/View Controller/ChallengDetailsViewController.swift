//
//  ChallengDetailsViewController.swift
//  Estaed
//
//  Created by arwa balawi on 24/05/1443 AH.
//

import Foundation
import UIKit

class ChallengDetailsViewController: UIViewController {
  
  @IBOutlet weak var quistionOfChalleng: UITextField!
  @IBOutlet weak var answerA: UITextField!
  @IBOutlet weak var answerB: UITextField!
  @IBOutlet weak var answerC: UITextField!
  @IBOutlet weak var answerD: UITextField!
  @IBOutlet weak var correctAnswer: UITextField!
  @IBOutlet weak var solutionMethod: UITextField!
  @IBOutlet weak var doneBtn: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}
