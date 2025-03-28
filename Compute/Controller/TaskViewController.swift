//
//  TaskViewController.swift
//  Compute
//
//  Created by William Halliday on 18/02/2025.
//

import UIKit
import FirebaseAuth

class TaskViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var algorithmView: UIView!
    @IBOutlet weak var dynamicView: UIView!
    @IBOutlet weak var mathView: UIView!
    @IBOutlet weak var streakView: UIView!
    @IBOutlet weak var coinsDayOne: UIView!
    @IBOutlet weak var coinsDayTwo: UIView!
    @IBOutlet weak var coinsDayThree: UIView!
    @IBOutlet weak var wellView: UIView!
    @IBOutlet weak var pointsItem: UIBarButtonItem!
    
    var language: String = "Python"
    var brain: TasksBrain = TasksBrain()

    override func viewDidLoad() {
        
        UserData.shared
        taskTableView.dataSource = self
        taskTableView.delegate = self
        taskTableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "Tony")
        
        Task {
            let gold = await UserData.shared.query(for: "gold")
            pointsItem.title = "₡\(gold)"
        }
        
        checkMode()
            
        setupViews(setup: true)
    }
    
    func setupViews(setup s: Bool) -> Void {
        dataView.customView(setup: s)
        algorithmView.customView(setup: s)
        dynamicView.customView(setup: s)
        mathView.customView(setup: s)
        streakView.customView(setup: s)
        coinsDayOne.customView(setup: s)
        coinsDayTwo.customView(setup: s)
        coinsDayThree.customView(setup: s)
        wellView.customView(setup: s)
    }
    
    @IBAction func languageChosen(_ sender: BounceButton) {
        language = (sender.titleLabel?.text!)!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if brain.tasks[indexPath.row].name == "Code rush"{
            performSegue(withIdentifier: Constants.codeRushSegue, sender: self)
        } else if brain.tasks[indexPath.row].name == "Deep dive" {
            performSegue(withIdentifier: Constants.deepDiveSegue, sender: self)
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: Constants.startSegue, sender: self)
        } catch let signOutError as NSError {
            print(signOutError)
        }
    }
    
    func checkMode() -> Void {
        if (traitCollection.userInterfaceStyle != .dark) {
            backgroundView.setGradientBackground(colorTop: .backgroundColour, colorBottom: .mainColour)
        } else {
            backgroundView.setGradientBackground(colorTop: .backgroundColour, colorBottom: .mainColour)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        checkMode()
        setupViews(setup: false)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToDeepDive") {
            let destinationVC = segue.destination as? DeepDiveViewController
            destinationVC?.language = language
        } else {
            let destinationVC = segue.destination as? CountDownViewController
            destinationVC?.language = language
        }
    }
    
    
}

extension TaskViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brain.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tony", for: indexPath)
        as! TaskCell
        let difficulty = brain.tasks[indexPath.row].difficulty
        cell.difficultyLabel.text = difficulty
        cell.nameLabel.text = brain.tasks[indexPath.row].name
        cell.elementImage.image = brain.tasks[indexPath.row].image
        cell.difficultyLabel.textColor = brain.colours[difficulty]
        return cell
    }
    
    
}
