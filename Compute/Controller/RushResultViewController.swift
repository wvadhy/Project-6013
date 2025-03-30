//
//  RushResultViewController.swift
//  Compute
//
//  Created by William Halliday on 24/02/2025.
//

import UIKit

class RushResultViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var overviewView: UIView!
    @IBOutlet weak var goldLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewView.customView(setup: true)
        scoreLabel.text = "\(CodeRushBrain.shared.correct)/10"
        goldLabel.text = "\(CodeRushBrain.shared.correct)"
        feedbackLabel.text = ""
        
        Task {
            await CodeRushBrain.shared.updateEntries()
        }
    }

}
