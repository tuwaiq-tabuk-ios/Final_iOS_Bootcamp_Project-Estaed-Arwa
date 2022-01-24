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
   // &&
    var model = User()
    var pimage: UIImage!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
  
  override func viewDidLoad() {
      super.viewDidLoad()
    
    //Too: hide back button come frome previous interface
    navigationItem.hidesBackButton = true
      // To make Circle Image
      imageView.layer.masksToBounds = true
      imageView.layer.cornerRadius = imageView.frame.height / 2
      getData()
      
  }
  
  
    @IBOutlet weak var languageSegmentControl: UISegmentedControl! {
        didSet
        {
            if let lang = UserDefaults.standard.string(forKey: "currentLanguage"){
                switch lang {
                case "ar":
                    languageSegmentControl.selectedSegmentIndex = 0
                    UIView.appearance().semanticContentAttribute = .forceLeftToRight
                case "en":
                    languageSegmentControl.selectedSegmentIndex = 1
                    UIView.appearance().semanticContentAttribute = .forceLeftToRight
                default:
                    let localLang = Locale.current.languageCode
                    if localLang == "en"{
                        languageSegmentControl.selectedSegmentIndex = 1
                    }else {
                        languageSegmentControl.selectedSegmentIndex = 0
                    }
                }
            }else {
                let localLang = Locale.current.languageCode
                UserDefaults.standard.setValue([localLang], forKey: "AppleLanguage")
                if localLang == "en" {
                    languageSegmentControl.selectedSegmentIndex = 0
                }else{
                    languageSegmentControl.selectedSegmentIndex = 1
                }
            }
        }
    }
    
    @IBAction func languageSegmentControl(_ sender: UISegmentedControl) {
        if let lang = sender.titleForSegment(at: sender.selectedSegmentIndex)?.lowercased(){
            UserDefaults.standard.setValue(lang, forKey: "currentLanguage")
            Bundle.setLanguage(lang)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            if let windowScane = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScane.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController =
                storyboard.instantiateInitialViewController()
                
            }
        }
    }
    
    
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        try? Auth.auth().signOut()
        
        let homeViewcontroller = self.storyboard? .instantiateViewController(identifier: Constant.storyboard.LoginViewController)
        
        self.view.window?.rootViewController = homeViewcontroller
        self.view.window?.makeKeyAndVisible()
        
        
    }
    
    
    func getData()
    {
        let id = Auth.auth().currentUser?.uid
        print("userId : \(id!)")
        Database.database().reference().child("users").child(id!).observe(.value, with: {  Data in
            if let data = Data.value as? NSDictionary , Data.exists(){
                
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
        
        if let next = storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProFileViewController{
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

