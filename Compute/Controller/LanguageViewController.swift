import Foundation
import UIKit

class LanguageViewController: UIViewController {
    
    @IBOutlet weak var beginner: BounceButton!
    @IBOutlet weak var intermediate: BounceButton!
    @IBOutlet weak var expert: BounceButton!
    @IBOutlet weak var nextPage: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        beginner.layer.cornerRadius = 15
        intermediate.layer.cornerRadius = 15
        expert.layer.cornerRadius = 15
        
        nextPage.layer.cornerRadius = 25
    }
    
    @IBAction func languageSelected(_ sender: BounceButton) {
        if sender.titleLabel?.text == "Beginner" {
            beginner.isEnabled = false
            intermediate.isEnabled = true
            expert.isEnabled = true
        } else if sender.titleLabel?.text == "Intermediate" {
            beginner.isEnabled = true
            intermediate.isEnabled = false
            expert.isEnabled = true
        } else {
            beginner.isEnabled = true
            intermediate.isEnabled = true
            expert.isEnabled = false
        }
        nextPage.isEnabled = true
    }
    
    
}
