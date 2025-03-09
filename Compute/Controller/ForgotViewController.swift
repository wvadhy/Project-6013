import UIKit
import FirebaseAuth

class ForgotViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var forgotTextField: UITextField!
    
    override func viewDidLoad() {
        forgotTextField.delegate = self
    }
    
    @IBAction func sendEmail(_ sender: UIButton) {
        if let email = forgotTextField.text {
            Auth.auth().sendPasswordReset(withEmail: email) { [self] error in
                if let e = error {
                    print("Error: \(e)")
                }
                
                let alert = UIAlertController(title: "Sent!", message: "Password reset has been sent to \(email)", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
                    print("Dismissed")
                }))
                
                present(alert, animated: true)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
}
