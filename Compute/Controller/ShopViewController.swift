 //
//  ShopViewController.swift
//  Compute
//
//  Created by William Halliday on 19/02/2025.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ShopViewController: UIViewController {
    
    @IBOutlet weak var timeSegmentControl: UISegmentedControl!
    @IBOutlet weak var pointsItem: UIBarButtonItem!
    @IBOutlet weak var playersTable: UITableView!
    
    var playerCount: Int = 0
    var players: [BoardData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            let gold = await UserData.shared.query(for: "gold")
            pointsItem.title = "₡\(gold)"
            playerCount = await BoardBrain.shared.getPlayerCount()
            
            players = await BoardBrain.shared.getPlayers()
            
            playersTable.dataSource = self
            playersTable.register(UINib(nibName: "BoardCell", bundle: nil), forCellReuseIdentifier: "Montana")
        }
        
        timeSegmentControl.customView(setup: true)

    }
    
}

extension ShopViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(playerCount)
        return playerCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Montana", for: indexPath)
        as! BoardCell
        cell.position.setTitle("\((indexPath.row)+1)", for: .normal)
        cell.name.text = players[indexPath.row].name
        cell.points.text = "\(players[indexPath.row].points)"
        return cell
    }
    
    
}
