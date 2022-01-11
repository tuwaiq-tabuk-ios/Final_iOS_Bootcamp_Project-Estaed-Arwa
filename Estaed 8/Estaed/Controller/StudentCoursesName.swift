//
//  StudentCoursesName.swift
//  Estaed
//
//  Created by arwa balawi on 29/05/1443 AH.
//

import UIKit

class StudentCoursesName: UIViewController {

  let story = UIStoryboard(name: "Main", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
  @IBAction func buttonTapped(_ Sender : UIButton)
  {
    
      Constant.courseName = Constant.Qudrat
    if let next = story.instantiateViewController(identifier: "StudentTimeKindViewController") as? StudentTimeKindViewController{
      next.modalPresentationStyle = .fullScreen
      self.present(next, animated: true, completion: nil)
    }
     
   
  }
  @IBAction func buttonTapped2(_ Sender : UIButton)
  {
    
      
   
      Constant.courseName = Constant.Tahsely
    if let next = story.instantiateViewController(identifier: "StudentTimeKindViewController") as? StudentTimeKindViewController{
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
