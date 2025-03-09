//
//  TaskInfoViewController.swift
//  Compute
//
//  Created by William Halliday on 19/02/2025.
//

import UIKit

class TaskInfoViewController: UIViewController {
    
    
    @IBOutlet weak var tasksSegmentControl: UISegmentedControl!
    
    
    @IBOutlet weak var tasksSlideOneAnimated: UIImageView!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var headingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func segementChanged(_ sender: UISegmentedControl) {
        
        if tasksSegmentControl.selectedSegmentIndex == 0 {
            tasksSlideOneAnimated.image = UIImage(named: "tasksSlideOne")
            headingLabel.text = "Do tasks"
            infoLabel.text = "Tasks will appear periodically over time, different task categories and difficulties will result in varying rewards."
        } else if tasksSegmentControl.selectedSegmentIndex == 1 {
            tasksSlideOneAnimated.image = UIImage(named: "tasksSlideTwo")
            headingLabel.text = "Get rewards"
            infoLabel.text = "Rewards will be granted upon successful completion of a task, these will vary depending on the difficulty of the task."
        } else {
            tasksSlideOneAnimated.image = UIImage(named: "tasksSlideThree")
            headingLabel.text = "Continue streaks"
            infoLabel.text = "Active completion of tasks everyday results in bonus rewards everytime you login and anytime you complete subsequent tasks."
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
