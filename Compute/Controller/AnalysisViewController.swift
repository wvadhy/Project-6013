import UIKit
import FirebaseFirestore

class AnalysisViewController: UIViewController {
    
    @IBOutlet weak var proView: UITextView!
    @IBOutlet weak var proViewTwo: UITextView!
    @IBOutlet weak var proViewThree: UITextView!
    @IBOutlet weak var proViewFour: UITextView!
    
    @IBOutlet weak var conView: UITextView!
    @IBOutlet weak var conViewTwo: UITextView!
    @IBOutlet weak var conViewThree: UITextView!
    @IBOutlet weak var conViewFour: UITextView!
    
    @IBOutlet weak var feedbackBackground: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreBar: UIProgressView!
    
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var loader: UIImageView!
    
    
    var code: String = ""
    var language: String = "Python"
    var proViews: [UITextView] = []
    var conViews: [UITextView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        proViews.append(proView)
        proViews.append(proViewTwo)
        proViews.append(proViewThree)
        proViews.append(proViewFour)
        
        conViews.append(conView)
        conViews.append(conViewTwo)
        conViews.append(conViewThree)
        conViews.append(conViewFour)
                
        feedbackBackground.customView(setup: true)
        
        for i in 0...3 {
            proViews[i].layer.cornerRadius = 15
            conViews[i].layer.cornerRadius = 15
        }
        
        loader.image = UIImage.gifImageWithName("computeLoader")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Task {
            await setupPage()
            UIView.animate(withDuration: 1) {
                self.coverView.alpha = 0
            }
        }
        
    }
    
    func setupPage() async -> Void {
        let result = await DeepDiveBrain.shared.analyseAnswer(for: language, with: code)
        
        for i in 0...3 {
            proViews[i].text = result.analysis[i].positive
            conViews[i].text = result.analysis[i].negative
        }
        
        scoreLabel.text = "\(result.score)%"
        scoreBar.setProgress(Float(result.score) / 100, animated: true)
    }

}
