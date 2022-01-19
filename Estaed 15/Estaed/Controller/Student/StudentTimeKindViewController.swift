//
//  StudentTimeKindViewController.swift
//  Estaed
//
//  Created by arwa balawi on 29/05/1443 AH.
//

import UIKit

class StudentTimeKindViewController: UIViewController {
let story = UIStoryboard(name: "Main", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  @IBAction func buttonTapped(_ Sender : UIButton)
  {
    
    Constant.courseTimeKind = Constant.Crash
    if let next = story.instantiateViewController(identifier: "StudentCourseDetails") as? StudentCourseDetails{
      next.modalPresentationStyle = .fullScreen
      self.present(next, animated: true, completion: nil)
    }
     
   
  }
  @IBAction func buttonTapped2(_ Sender : UIButton)
  {
    
      
   
      Constant.courseTimeKind = Constant.Normal
    if let next = story.instantiateViewController(identifier: Constant.storyboard.StudentCourseDetails) as? StudentCourseDetails{
      next.modalPresentationStyle = .fullScreen
      self.present(next, animated: true, completion: nil)
   
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
