//
//  BounceButton.swift
//  Compute
//
//  Created by William Halliday on 25/02/2025.
//

import UIKit

class BounceButton: UIButton {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction) {
            self.transform = CGAffineTransform.identity
        }
        super.touchesBegan(touches, with: event)
    }

}
