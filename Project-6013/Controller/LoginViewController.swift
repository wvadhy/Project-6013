//
//  ViewController.swift
//  Project-6013
//
//  Created by William Halliday on 27/09/2024.
//

import UIKit

class LoginViewController: UIViewController {
    

    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func signupPressed(_ sender: UIButton) {
        loginButton.doGlowAnimation(withColor: .magenta, withEffect: .big)
    }
    
    @IBAction func emailEntryStarted(_ sender: UITextField) {
        emailTextField.doGlowAnimation(withColor: .magenta)
    }
    
    @IBAction func passwordEntryStarted(_ sender: UITextField) {
        passwordTextField.doGlowAnimation(withColor: .magenta)
    }
    
    
    
}

extension UIView {
    enum GlowEffect: Float {
        case small = 0.4, normal = 2, big = 15
    }

    func doGlowAnimation(withColor color: UIColor, withEffect effect: GlowEffect = .normal) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowRadius = .zero
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
    
        let glowAnimation = CABasicAnimation(keyPath: "shadowRadius")
        glowAnimation.fromValue = Int.zero
        glowAnimation.toValue = effect.rawValue
        glowAnimation.beginTime = CACurrentMediaTime()
        glowAnimation.duration = CFTimeInterval(0.3)
        glowAnimation.fillMode = .removed
        glowAnimation.autoreverses = true
        glowAnimation.isRemovedOnCompletion = true
        layer.add(glowAnimation, forKey: "shadowGlowingAnimation")
    }
}
