//
//  BoardCell.swift
//  Compute
//
//  Created by William Halliday on 28/03/2025.
//

import UIKit

class BoardCell: UITableViewCell {
    
    
    @IBOutlet weak var position: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var bubble: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bubble.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
