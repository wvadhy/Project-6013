import Foundation
import UIKit

class ExperienceViewController: UIViewController {
    
    @IBOutlet weak var goNext: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    @IBAction func languageSelected(_ sender: BounceButton) {
        sender.isEnabled = false
        goNext.isEnabled = true
    }
    
}
