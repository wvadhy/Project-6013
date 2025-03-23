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
    
    var textView: UITextView = UITextView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    var language: String = "Python"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        codeView.customView(setup: true)
        view.setGradientBackground(colorTop: .white, colorBottom: UIColor(red: 242, green: 239, blue: 231, alpha: 1))
        
        let textStorage = CodeAttributedString()
        textStorage.language = language
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)

        let textContainer = NSTextContainer(size: view.bounds.size)
        layoutManager.addTextContainer(textContainer)

        textView = UITextView(frame: CGRect(x: 8, y: 8, width: 304, height: 460), textContainer: textContainer)
        
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.spellCheckingType = .no
        
        codeView.addSubview(textView)
        
        setupPage()
    }
    
    func setupPage() -> Void {
        Task {
            let text = await DeepDiveBrain.shared.getQuestion(for: language)
            textView.text = text
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) { codeView.customView() }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? AnalysisViewController
        destinationVC?.code = textView.text!
        destinationVC?.language = language
    }

}
