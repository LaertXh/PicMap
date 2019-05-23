//
//  PostViewController.swift
//  PicMap
//
//  Created by Jiade Lin on 5/23/19.
//  Copyright © 2019 Laert Xhumari. All rights reserved.
//
import UIKit
import AlamofireImage
import Parse
class PostViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentFiled.delegate = self
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }    
    @IBAction func onSubmitButton(_ sender: Any) {
        let user = PFUser.current()
        let post = PFObject(className: "Posts")
        post["caption"] = commentFiled.text
        post["author"] = PFUser.current()
        post["ID"] = user?.objectId
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        post["image"] = file
        
        post.saveInBackground(){(success,error) in
            if success{
                self.performSegue(withIdentifier: "backMap", sender: nil)
                print("saved!")
            }else{
                print("fail!")
            }
            
        }
    }
    @IBAction func onCamerButton(_ sender: Any) {
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

