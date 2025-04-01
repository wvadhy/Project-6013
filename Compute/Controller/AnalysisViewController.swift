import UIKit
import FirebaseFirestore
import Highlightr

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
    
    var textView: UITextView = UITextView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

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
        
        let textStorage = CodeAttributedString()
        textStorage.language = language
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)

        let textContainer = NSTextContainer(size: view.bounds.size)
        layoutManager.addTextContainer(textContainer)

        textView = UITextView(frame: CGRect(x: 30, y: 424, width: 300, height: 180), textContainer: textContainer)
        
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.spellCheckingType = .no
        textView.backgroundColor = .black
        textView.layer.cornerRadius = 10
        
        feedbackBackground.addSubview(textView)
                
        feedbackBackground.customView(setup: true)
        
        for i in 0...3 {
            proViews[i].layer.cornerRadius = 10
            conViews[i].layer.cornerRadius = 10
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
        
        DeepDiveBrain.shared.updatePoints(for: Int(result.score))
        
        textView.text = DeepDiveBrain.shared.current[0].solution
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        DeepDiveBrain.shared.reset()
    }

}
