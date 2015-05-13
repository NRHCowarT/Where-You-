//
//  TakePictureViewController.swift
//  Where You @
//
//  Created by Nick Cowart on 3/4/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit

class TakePictureViewController: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    var imagePicker = UIImagePickerController()
        
    @IBOutlet weak var pictureCapturedView: UIImageView!
   
    @IBOutlet weak var takePictureLabel: UIButton!
    
    @IBAction func menuButton(sender: AnyObject) {
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func takePictureButton(sender: AnyObject) {
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if pictureCapturedView.image == nil{
            
            presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pictureCapturedView.clipsToBounds = true
        
        imagePicker.delegate = self
        
        imagePicker.sourceType = .Camera
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.pictureCapturedView.image = image
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func resizeImage(image: UIImage, withSize size: CGSize) -> UIImage{
        
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
    
    @IBAction func savePictureButton(sender: AnyObject) {
        
        GameData.mainData().newPicture = PFObject(className: "Picture")
        GameData.mainData().newPicture?["creator"] = PFUser.currentUser()
        GameData.mainData().newPicture?["facebookId"] = PFUser.currentUser()["facebookId"]
        
        if let originalImage = pictureCapturedView.image {
            
            if let image = resizeImage(originalImage, withSize: CGSizeMake(540, 540)) as UIImage? {
                
                let imageData = UIImagePNGRepresentation(image)
                
                let imageFile = PFFile(name: "image.png", data: imageData)
                GameData.mainData().newPicture?["image"] = imageFile
                
                
                GameData.mainData().newPicture?.saveInBackground()
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("SelectCorrectVenueVC") as! SelectCorrectVenueVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
        }else{
            
            let alert = UIAlertController(title: "Take a Pic!", message: "You forgetting something?", preferredStyle: UIAlertControllerStyle.Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(defaultAction)
            
            presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
