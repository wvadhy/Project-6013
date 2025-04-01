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
                    UserData.shared
                    Task {
                        do {
                            let ref = try await db.collection("users").document(UserData.shared.user!.uid).setData([
                            "name": nameTextField.text!,
                            "email": email,
                            "gold": 0,
                            "pointsTotal": 0,
                            "totalGamesPlayed": 1,
                            "codeRushPlayed": 1,
                            "codeRushHighScore": 0,
                            "codeRushCorrect": 0,
                            "codeRushAverage": 0.0,
                            "codeRushTotal": 0,
                            "deepDivePlayed": 1,
                            "deepDiveHighScore": 0,
                            "deepDiveCorrect": 0,
                            "deepDiveAverage": 0.0,
                            "deepDiveTotal": 0,
                            "codeRushAverageRuby": 0.0,
                            "codeRushTotalRuby": 0,
                            "deepDiveAverageRuby": 0.0,
                            "deepDiveTotalRuby": 0,
                            "codeRushAverageCpp": 0.0,
                            "codeRushTotalCpp": 0,
                            "deepDiveAverageCpp": 0.0,
                            "deepDiveTotalCpp": 0,
                            "codeRushAverageJava": 0.0,
                            "codeRushTotalJava": 0,
                            "deepDiveAverageJava": 0.0,
                            "deepDiveTotalJava": 0,
                            "codeRushAverageLua": 0.0,
                            "codeRushTotalLua": 0,
                            "deepDiveAverageLua": 0.0,
                            "deepDiveTotalLua": 0,
                            "codeRushAveragePython": 0.0,
                            "codeRushTotalPython": 0,
                            "deepDiveAveragePython": 0.0,
                            "deepDiveTotalPython": 0,
                            "codeRushAverageJs": 0.0,
                            "codeRushTotalJs": 0,
                            "deepDiveAverageJs": 0.0,
                            "deepDiveTotalJs": 0,
                            "pythonScore": 0,
                            "rubyScore": 0,
                            "cppScore": 0,
                            "javaScore": 0,
                            "jsScore": 0,
                            "luaScore": 0,
                            "rank": 0
                          ])
                            print("Document added with ID: \(UserData.shared.user!.uid)")
                        } catch {
                          print("Error adding document: \(error)")
                        }
                        self.performSegue(withIdentifier: Constants.customiseSegue, sender: self)
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
