import UIKit
import FirebaseFirestore

class LeaderboardInfoViewController: UIViewController {
    
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        if segmentControl.selectedSegmentIndex == 0 {
            displayImage.image = UIImage(named: "leaderboardSlideOne")
            headingLabel.text = "Get Points"
            infoLabel.text = "Points can be obtained by either completing daily tasks or event tasks, these points will be categorised into seperate rankings."
        } else if segmentControl.selectedSegmentIndex == 1 {
            displayImage.image = UIImage(named: "leaderboardSlideTwo")
            headingLabel.text = "Climb Rankings"
            infoLabel.text = "Rankings will be seperated into different categories for the specific types of tasks completed, these ranking will be reset every week."
        }
    }
    
    
}
