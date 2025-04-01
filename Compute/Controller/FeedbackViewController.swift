import UIKit
import FirebaseFirestore

class FeedbackViewController: UIViewController {
    
    
    @IBOutlet weak var feedbackMiniView: UIView!
    @IBOutlet weak var prosAndConsView: UIView!
    @IBOutlet weak var pageName: UILabel!
    @IBOutlet weak var pointsLabel: UIBarButtonItem!
    @IBOutlet weak var prosAndConsText: UITextView!
    @IBOutlet weak var welcomeName: UILabel!
    @IBOutlet weak var tasksDone: UILabel!
    @IBOutlet weak var dailyTasks: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedbackMiniView.customView(setup: true)
        prosAndConsView.layer.cornerRadius = 15
        prosAndConsView.layer.borderWidth = 2
        prosAndConsView.layer.borderColor = UIColor.black.cgColor
        
        Task {
            let gold = await UserData.shared.query(for: "gold")
            let name = await UserData.shared.query(for: "name")
            let totalGames = await UserData.shared.query(for: "totalGamesPlayed")
            
            pointsLabel.title = "₡\(gold)"
            welcomeName.text = "Hey, \(name)!"
            tasksDone.text = totalGames
            dailyTasks.text = "\(totalGames)/10"
            
            let progressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), lineWidth: 10, rounded: false)
            
            progressView.progressColor = .mainColour
            progressView.trackColor = .lightGray
            progressView.center = CGPoint(x: 310, y: 170)
            
            view.addSubview(progressView)
            
            progressView.progress = Float(0.3)
        }
    }
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        
        if (sender.currentPage == 0){
            prosAndConsText.text = FeedbackBrain.shared.strength
            prosAndConsView.backgroundColor = UIColor.correct
            prosAndConsText.backgroundColor = UIColor.correct
            pageName.text = "Strengths"
        } else if (sender.currentPage == 1){
            prosAndConsText.text = FeedbackBrain.shared.weakness
            prosAndConsView.backgroundColor = UIColor.wrong
            prosAndConsText.backgroundColor = UIColor.wrong
            pageName.text = "Weaknesses"
        } else {
            prosAndConsText.text = FeedbackBrain.shared.todo
            prosAndConsView.backgroundColor = UIColor.orange
            prosAndConsText.backgroundColor = UIColor.orange
            pageName.text = "How to improve"
        }
        
    }
    
    
}
