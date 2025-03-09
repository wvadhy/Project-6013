//
//  QuestionViewController.swift
//  Compute
//
//  Created by William Halliday on 19/02/2025.
//

import UIKit

class CountDownViewController: UIViewController {
    
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    let countdown: [String] = ["3", "2", "1", "RUSH!"]
    var index: Double = 0.0
    var questions: [CodeRushQuestion] = []
    var language: String = "Python"
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        startTimer { [self] in
            Task {
                questions = await CodeRushBrain.shared.getQuestions(for: language)
                performSegue(withIdentifier: "goToQuestion", sender: self)
            }
        }
    }
    
    func startTimer(completion handler: @escaping () -> Void) {
        for i in countdown {
            Timer.scheduledTimer(withTimeInterval: index * 1.0, repeats: false) { (timer) in
                self.countdownLabel.text = i
                if (i == "2") {
                    handler()
                }
            }
            index += 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? QuestionViewController
        destinationVC?.questions = questions
        destinationVC?.language = language
    }

}
