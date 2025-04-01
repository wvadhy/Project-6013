//
//  DeepDiveViewController.swift
//  Compute
//
//  Created by William Halliday on 27/02/2025.
//

import UIKit
import Highlightr

class DeepDiveViewController: UIViewController {
    
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var loader: UIImageView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var helper: UITextView!
    
    var textView: UITextView = UITextView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    var language: String = "Python"
    var difficulty: Int = 1
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let textStorage = CodeAttributedString()
        textStorage.language = language
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)

        let textContainer = NSTextContainer(size: view.bounds.size)
        layoutManager.addTextContainer(textContainer)

        textView = UITextView(frame: CGRect(x: 8, y: 8, width: 304, height: 360), textContainer: textContainer)
        
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.spellCheckingType = .no
        textView.backgroundColor = .black
        
        codeView.addSubview(textView)
        
        codeView.customView(setup: true)
        
        loader.image = UIImage.gifImageWithName("computeLoader")
    }
    
    @IBAction func helpMePressed(_ sender: BounceButton) {
        
        sender.isEnabled = false
        sender.backgroundColor = .accent
        sender.layer.cornerRadius = 10
        
        Task {
            helper.text = await DeepDiveBrain.shared.getHelp()
        }
        
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
        let result = await DeepDiveBrain.shared.getQuestion(for: language)[0]
        textView.text = result.code
        inputLabel.text = result.output
        outputLabel.text = result.input
        questionLabel.text = result.question
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) { codeView.customView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? AnalysisViewController
        destinationVC?.code = textView.text!
        destinationVC?.language = language
    }

}
