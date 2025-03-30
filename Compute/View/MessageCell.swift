//
//  MessageCell.swift
//  Compute
//
//  Created by William Halliday on 30/03/2025.
//

import UIKit

class MessageCell: UITableViewCell {
    
    
    @IBOutlet weak var messageBox: UIView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var leftimage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBox.layer.cornerRadius = messageBox.frame.size.height / 5
        messageBox.layer.borderWidth = 1
        messageBox.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
