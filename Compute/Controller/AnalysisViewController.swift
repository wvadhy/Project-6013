import UIKit
import FirebaseFirestore

class AnalysisViewController: UIViewController {
    
    @IBOutlet weak var proView: UITextView!
    @IBOutlet weak var conView: UITextView!
    @IBOutlet weak var feedbackBackground: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreBar: UIProgressView!
    @IBOutlet weak var loading: UIImageView!
    
    var code: String = ""
    var language: String = "Python"

    override func viewDidLoad() {
        super.viewDidLoad()
                
        feedbackBackground.customView(setup: true)
        proView.layer.cornerRadius = 15
        conView.layer.cornerRadius = 15
        setupPage()
    }
    
    func setupPage() -> Void {
        loading.image = UIImage.gifImageWithName("loading")
        Task {
            let result = await DeepDiveBrain.shared.analyseAnswer(for: language, with: code)
            proView.text = result.analysis[0].positive
            conView.text = result.analysis[2].negative
            scoreLabel.text = "\(result.score)%"
            scoreBar.setProgress(Float(result.score) / 100, animated: true)
            loading.isHidden = true
        }
    }

}
