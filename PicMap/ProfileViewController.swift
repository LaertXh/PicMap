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
class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var NickName: UILabel!
    @IBOutlet weak var UserStory: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
    
        let user = PFUser.current()
        query.includeKey("author")
        query.whereKey("ID", equalTo: user?.objectId)
        query.limit = 20
        
        query.findObjectsInBackground{ (posts,error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        
        let user = post["author"] as! PFUser
        
        if user["NickName"] != nil{
            cell.usernameLable.text = user["NickName"] as? String
        }
        
        cell.captionLable.text = post["caption"] as! String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        cell.photoView.af_setImage(withURL: url)
        
        return cell
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
