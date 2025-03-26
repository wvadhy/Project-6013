import UIKit
import FirebaseFirestore

class StatsInfoViewController: UIViewController {

    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var displayImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        
        if segmentControl.selectedSegmentIndex == 0 {
            displayImage.image = UIImage(named: "statsInfoSlideOne")
            headingLabel.text = "Upgrade Ranking"
            infoLabel.text = "Your rank will gradually increase the more tasks you complete, the points from each task completed contributing to your rank."
        } else if segmentControl.selectedSegmentIndex == 1 {
            displayImage.image = UIImage(named: "statsInfoSlideTwo")
            headingLabel.text = "Find Users"
            infoLabel.text = "Use the search bar to locate friends, or rivals and use them as motivation to earn more badges!"
        }
        
    }
    
    
}
