import UIKit
import MobileCoreServices

// Enums
enum CameraMode {
    case Rear
    case Front
}

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var rearImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    
    var newMedia: Bool?
    
    // Enum Parameters
    func cameraPhoto(cameraMode : CameraMode) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            //Enum Parameters to Pass
            imagePicker.cameraDevice = cameraMode == CameraMode.Front ? .Front : .Rear
            imagePicker.mediaTypes = [kUTTypeImage as NSString as String]
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
            newMedia = true
        }
    }
    
    @IBAction func rearCameraPhoto(sender: UIButton) {cameraPhoto(.Rear)}
    
    @IBAction func frontCameraPhoto(sender: UIButton) {
        cameraPhoto(.Front)
    }
    @IBAction func frontImage(sender: UITapGestureRecognizer) {
        cameraPhoto(.Front)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if picker.cameraDevice == .Front {
            picker.dismissViewControllerAnimated(true, completion: nil)
            frontImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            frontImageView.clipsToBounds = true
            frontImageView.contentMode = UIViewContentMode.ScaleAspectFill
            frontImageView.transform = CGAffineTransformMakeScale(-1, 1)
        } else {
            picker.dismissViewControllerAnimated(true, completion: nil)
            rearImageView.transform = CGAffineTransformIdentity            
            rearImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            rearImageView.clipsToBounds = true
            rearImageView.contentMode = UIViewContentMode.ScaleAspectFill
        }
    }
    
    //Need to figure out how to ScaleAspectFill and reverse Front Camera Photo
    func getVerticalImg() -> UIImage {
        let photoSize = CGSizeMake(rearImageView.image!.size.width, rearImageView.image!.size.width * 2)
        //let photoSize = CGSizeMake(width: CGFloat, height: CGFloat)
        
        UIGraphicsBeginImageContext(photoSize)
        
        rearImageView.image!.drawInRect(CGRectMake(0, 0, photoSize.width, photoSize.width))
        frontImageView.image!.drawInRect(CGRectMake(0, photoSize.width, photoSize.width, photoSize.width))
        //rearImageView.image!.drawinRect(CGRectMake(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)
        
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return finalImage
    }
    
    @IBAction func savePhoto(sender: UIButton) {
        let finalMixedImage = getVerticalImg()
        UIImageWriteToSavedPhotosAlbum(finalMixedImage, nil, nil, nil);
        self.savedImageAlert()
    }
    
    func savedImageAlert() {
        let alertController = UIAlertController(title: "It worked!", message: "Your picture was saved to Camera Roll.", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in}
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) {}
    }
    
    @IBAction func sharePhoto(sender: AnyObject) {
        let finalMixedImage = getVerticalImg()
        self.displayShareSheet(finalMixedImage)
    }
    
    func displayShareSheet(image:UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: {})
    }
    
}