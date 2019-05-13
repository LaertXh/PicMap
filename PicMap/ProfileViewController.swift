//
//  ProfileViewController.swift
//  PicMap
//
//  Created by Jiade Lin on 5/9/19.
//  Copyright © 2019 Laert Xhumari. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
class ProfileViewController: UIViewController{
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var NickName: UILabel!
    @IBOutlet weak var UserStory: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.current()!
        if user["NickName"] != nil{
            NickName.text = user["NickName"] as? String
        }
        if user["UserStory"] != nil{
            UserStory.text = user["UserStory"] as? String
        }
        if user["ProfileImage"] != nil{
            let imageFile = user["ProfileImage"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            ProfileImage.af_setImage(withURL: url)
        }
     
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = loginViewController
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
