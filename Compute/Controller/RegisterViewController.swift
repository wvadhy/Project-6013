import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var db: Firestore = Firestore.firestore()
        
    override func viewDidLoad() {
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    @IBAction func signupPressed(_ sender: UIButton) {
    
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, err in
                if let e = err {
                    self.showAlert(message: e.localizedDescription)
                } else {
                    Task {
                        do {
                          let ref = try await db.collection("users").addDocument(data: [
                            "name": nameTextField.text!,
                            "email": email,
                            "points": 0,
                            "rank": 0
                          ])
                          print("Document added with ID: \(ref.documentID)")
                        } catch {
                          print("Error adding document: \(error)")
                        }
                        self.performSegue(withIdentifier: "goToMain", sender: self)
                    }
                }
            }
        }
        
    }
    
    func showAlert(message msg: String){
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
            print("Dismissed")
        }))
        
        present(alert, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
