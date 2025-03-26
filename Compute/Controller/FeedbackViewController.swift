import UIKit
import FirebaseFirestore

class FeedbackViewController: UIViewController {
    
    
    @IBOutlet weak var feedbackMiniView: UIView!
    @IBOutlet weak var prosAndConsView: UIView!
    @IBOutlet weak var pageName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedbackMiniView.customView(setup: true)
        prosAndConsView.layer.cornerRadius = 15
        prosAndConsView.layer.borderWidth = 2
        prosAndConsView.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        
        if (sender.currentPage == 0){
            prosAndConsView.backgroundColor = UIColor.correct
            pageName.text = "Strengths"
        } else if (sender.currentPage == 1){
            prosAndConsView.backgroundColor = UIColor.wrong
            pageName.text = "Weaknesses"
        } else {
            prosAndConsView.backgroundColor = UIColor.orange
            pageName.text = "How to improve"
        }
        
    }
    
    
}
