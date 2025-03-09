//
//  TaskCell.swift
//  Compute
//
//  Created by William Halliday on 19/02/2025.
//

import UIKit

class TaskCell: UITableViewCell {
    
        
    @IBOutlet weak var taskBubble: UIView!
    
    @IBOutlet weak var difficultyLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var elementImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskBubble.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

