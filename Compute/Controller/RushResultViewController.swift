//
//  RushResultViewController.swift
//  Compute
//
//  Created by William Halliday on 24/02/2025.
//

import UIKit

class RushResultViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var overviewView: UIView!
    @IBOutlet weak var goldLabel: UILabel!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var feedbackLabel: UITextView!
    @IBOutlet weak var loader: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewView.customView(setup: true)
        scoreLabel.text = "\(CodeRushBrain.shared.correct)/10"
        goldLabel.text = "\(CodeRushBrain.shared.correct)"
        
        loader.image = UIImage.gifImageWithName("computeLoader")
        
        Task {
            feedbackLabel.text = await CodeRushBrain.shared.generateFeedback()
            await CodeRushBrain.shared.updateEntries()
            
            UIView.animate(withDuration: 1) {
                self.coverView.alpha = 0
            }
        }
    }

}
