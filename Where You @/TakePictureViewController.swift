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
    
    var pictureNumber:Int = 0
    
    @IBOutlet weak var pictureCapturedView: UIImageView!
    @IBOutlet weak var takePictureLabel: UIButton!
    
    @IBAction func menuButton(sender: AnyObject) {
        
        
        
        
    }
    
    @IBAction func takePictureButton(sender: AnyObject) {
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var image = info[UIImagePickerControllerOriginalImage] as UIImage
        
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
        
        var newPicture = PFObject(className: "Picture")
        newPicture["creator"] = PFUser.currentUser()
        
        if let originalImage = pictureCapturedView.image {
            
            if let image = resizeImage(originalImage, withSize: CGSizeMake(540, 540)) as UIImage? {
                
                let imageData = UIImagePNGRepresentation(image)
                
                let imageFile = PFFile(name: "\(PFUser.currentUser().username)\(pictureNumber++).png", data: imageData)
                newPicture["image"] = imageFile
                
                newPicture.saveInBackground()
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("SelectCorrectVenueVC") as SelectCorrectVenueVC
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
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
