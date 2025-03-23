import UIKit
import FirebaseFirestore

class AnalysisViewController: UIViewController {
    
    @IBOutlet weak var feedbackView: UITextView!
    @IBOutlet weak var feedbackBackground: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreBar: UIProgressView!
    @IBOutlet weak var loading: UIImageView!
    
    var code: String = ""
    var language: String = "Python"

    override func viewDidLoad() {
        super.viewDidLoad()
                
        feedbackBackground.customView(setup: true)
        setupPage()
    }
    
    func setupPage() -> Void {
        loading.image = UIImage.gifImageWithName("loading")
        Task {
            var result = await DeepDiveBrain.shared.analyseAnswer(for: language, with: code)[0]
            feedbackView.text = result.analysis
            scoreLabel.text = "\(result.score)%"
            scoreBar.setProgress(0.6, animated: true)
            loading.isHidden = true
        }
    }

}
