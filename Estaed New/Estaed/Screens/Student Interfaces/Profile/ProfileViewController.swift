//
//  ProfileStudent.swift
//  Estaed
//
//  Created by arwa balawi on 21/05/1443 AH.
//


import UIKit
import Firebase
import FirebaseAuth

class ProfileStudentViewController : UIViewController {
    
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
   
  var model = User()
  var pimage: UIImage!
  
    @IBAction func logOutButtonTapped(_ sender: Any) {
        try? Auth.auth().signOut()
        
//        let homeViewcontroller = self.storyboard? .instantiateViewController(identifier: Constant.storyboard.LoginViewController)
//        
//        self.view.window?.rootViewController = homeViewcontroller
//        self.view.window?.makeKeyAndVisible()
        
      if let next = storyboard?.instantiateViewController(identifier: "LogIn") as? LoginViewController{
        
        next.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(next, animated: true)
      }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // To make Circle Image
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.height / 2
        getData()
        
    }
    
    func getData()
    {
        let id = Auth.auth().currentUser?.uid
        print("userId : \(id!)")
        Database.database().reference().child("users").child(id!).observe(.value, with: {  Data in
            if let data = Data.value as? NSDictionary,
               Data.exists(){
                
                self.model = User(value: data)
                if !self.model.imageUrl.isEmpty
                {
                    let url = URL(string: self.model.imageUrl)
                    self.downloadImage(from: url!)
                  
                }
               
                self.nameLabel.text = self.model.firstName + " " + self.model.lasteName
            }
        })
    }
    
    @IBAction func didNaviBtnTapped(_ sender: Any) {
        
        if let next = storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController{
            next.model = model
            if self.pimage != nil {
                next.image = self.pimage
            }
            next.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(next, animated: false)
            
            
            
        }
    }
    func getImage(from url : URL , completion : @escaping (Data?,URLResponse? , Error?) ->())
    {
        URLSession.shared.dataTask(with: url, completionHandler: { Data, response, error in
            
            completion(Data, response, error)
        }).resume()
    }
    
    func downloadImage(from url : URL)
    {
        getImage(from: url) { data, response, error in
            guard let data = data , error == nil else {return}
                DispatchQueue.main.async() {
                    [weak self] in
                    self!.pimage = UIImage(data: data)
                    self?.imageView.image = self!.pimage
                
            }
        }
    }
    
}

