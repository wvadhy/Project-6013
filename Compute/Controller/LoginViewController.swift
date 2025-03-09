//
//  LoginViewController.swift
//  Compute
//
//  Created by William Halliday on 18/02/2025.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0
    var db: Firestore = Firestore.firestore()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        
        passwordTextField.delegate = self
        emailTextField.delegate = self
        
        Task {
            do {
              let snapshot = try await db.collection("users").getDocuments()
              for document in snapshot.documents {
                print("\(document.documentID) => \(document.data())")
              }
            } catch {
              print("Error getting documents: \(error)")
            }
        }
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authData, err in
                if let e = err {
                    self.showAlert(message: e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "goToMainFromLogin", sender: self)
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func showAlert(message msg: String){
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
            print("Dismissed")
        }))
        
        present(alert, animated: true)
    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { UserData.shared }
    
}
