import UIKit
import FirebaseFirestore

class AnalysisViewController: UIViewController {
    
    @IBOutlet weak var feedbackView: UITextView!
    @IBOutlet weak var feedbackBackground: UIView!
    
    var code: String = ""
    var language: String = "Python"

    override func viewDidLoad() {
        super.viewDidLoad()
                
        feedbackBackground.customView(setup: true)
        setupPage()
    }
    
    func setupPage() -> Void {
        Task {
            feedbackView.text = await DeepDiveBrain.shared.analyseAnswer(for: language, with: code)
        }
    }

}
