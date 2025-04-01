import Foundation
import UIKit

class DeepDiveResultViewController: UIViewController {
    
    var score: Int = 0
    @IBOutlet weak var goldLabel: UILabel!
    @IBOutlet weak var feedbackView: UITextView!
    @IBOutlet weak var coverview: UIView!
    @IBOutlet weak var loader: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.image = UIImage.gifImageWithName("computeLoader")
        
        Task {
            feedbackView.text = await DeepDiveBrain.shared.generateFeedback()
            goldLabel.text = "₡\(DeepDiveBrain.shared.points)"
            
            await DeepDiveBrain.shared.updateEntries()
            
            UIView.animate(withDuration: 1) {
                self.coverview.alpha = 0
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        DeepDiveBrain.shared.end()
    }
    
}
