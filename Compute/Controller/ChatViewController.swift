//
//  ViewController.swift
//  Compute
//
//  Created by William Halliday on 18/02/2025.
//

import UIKit
import CLTypingLabel
import FirebaseFirestore

class ChatViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var inputContainer: UIView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var messageView: UITableView!
    @IBOutlet weak var statusLabel: UILabel!
    
    var messages: [Receipt] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputContainer.layer.cornerRadius = 30
        inputContainer.layer.borderWidth = 1
        
        sendButton.layer.cornerRadius = 15
        messageField.delegate = self
        
        messageView.dataSource = self
        messageView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "Scarface")
        
        Task {
            let name = await UserData.shared.query(for: "name")
            messages.append(Receipt(body: "Hey \(name), how can I help today?", sender: "LLM"))
            messageView.reloadData()
        }
    }
    
    @IBAction func submitQuery(_ sender: UIButton) {
        
        let msg = messageField.text ?? "..."
        
        messages.append(Receipt(body: msg, sender: "User"))
        
        messageField.text = ""
        statusLabel.text = "analysing query..."
        messageView.reloadData()
        
        let indexPath = IndexPath(row: messages.count-1, section: 0)
        
        messageView.scrollToRow(at: indexPath, at: .top, animated: true)
        
        Task {
            let response = await ChatBrain.shared.fetchResponse(for: msg)
            
            messages.append(Receipt(body: response, sender: "LLM"))
            
            statusLabel.text = "awaiting input..."
            messageView.reloadData()
            
            let indexPath = IndexPath(row: messages.count-1, section: 0)
            
            messageView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Scarface", for: indexPath)
        as! MessageCell
        cell.message.text = message.body
        
        if message.sender == "User" {
            cell.leftimage.isHidden = true
            cell.rightImage.isHidden = false
            cell.messageBox.backgroundColor = UIColor.mainColour
        } else {
            cell.leftimage.isHidden = false
            cell.rightImage.isHidden = true
            cell.messageBox.backgroundColor = UIColor.secondary
        }
        
        return cell
    }
    
    
}


