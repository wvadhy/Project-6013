//
//  AccountViewController.swift
//  Compute
//
//  Created by William Halliday on 19/02/2025.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {
    
    
    @IBOutlet weak var accountTableView: UITableView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var options = [
        "Change course",
        "Push notifications",
        "Email notifications",
        "Account security",
        "Close account"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUserData()

        accountTableView.dataSource = self
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print(signOutError)
        }
    }
    
    func updateUserData() -> Void {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let email = user.email
        }
        emailLabel.text = (user?.email)!
        nameLabel.text = UserData.shared.name
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

extension AccountViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Ross", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    
}
