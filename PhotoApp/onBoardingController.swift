import UIKit

class onBoardingController: UIViewController {

    @IBOutlet weak var btnOnBoarding: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //btnOnBoarding Button Styles
        btnOnBoarding.layer.borderColor = UIColor.blueColor().CGColor // Set border color
        btnOnBoarding.layer.borderWidth = 1 // Set border width
        btnOnBoarding.layer.borderColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1).CGColor
        btnOnBoarding.layer.cornerRadius = 10
        btnOnBoarding.layer.backgroundColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1).CGColor
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goCamera(sender: AnyObject) {
        
    }


    


}