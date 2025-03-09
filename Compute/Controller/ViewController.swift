//
//  ViewController.swift
//  Compute
//
//  Created by William Halliday on 18/02/2025.
//

import UIKit
import CLTypingLabel

class ViewController: UIViewController {
    
    
    @IBOutlet weak var lightBulb: UIImageView!
    
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Compute."

        lightBulb.image = checkMode()
    }
    
    func checkMode() -> UIImage {
        if traitCollection.userInterfaceStyle != .dark {
            return UIImage.gifImageWithName("lightBulbLight")!
        } else {
            return UIImage.gifImageWithName("lightBulbDark")!
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        lightBulb.image = checkMode()
    }

}

