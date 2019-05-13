//
//  EditViewController.swift
//  PicMap
//
//  Created by Jiade Lin on 5/13/19.
//  Copyright © 2019 Laert Xhumari. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
class EditViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    @IBOutlet weak var userNickNameField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userStoryField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = PFUser.current()!
        
        if user["NickName"] != nil{
            userNickNameField.text = user["NickName"] as? String
        }
        if user["UserStory"] != nil{
            userStoryField.text = user["UserStory"] as? String
        }
        if user["ProfileImage"] != nil{
            let imageFile = user["ProfileImage"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            imageView.af_setImage(withURL: url)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
        let user = PFUser.current()!
        
        user["NickName"] = userNickNameField.text
        user["UserStory"] = userStoryField.text
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        user["ProfileImage"] = file
        user.saveInBackground{ (success, error)in
            if success{
                self.performSegue(withIdentifier: "backProfile", sender: nil)
            }else{
                print("Error:\(error?.localizedDescription)")
            }
        
        }
    }
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else{
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion:  nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
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
