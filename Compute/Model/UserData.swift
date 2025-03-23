import Foundation
import FirebaseFirestore
import FirebaseAuth

struct UserData {
    
    var coins: Int = 0
    var rank: Int = 1
    var name: String = ""
    
    
    var user: User?
    static let shared: UserData = UserData(for: Auth.auth().currentUser!)
    
    init(for person: User?) {
        print("Creating user data for: \(String(describing: user?.email))")
        user = person
    }
    
    private mutating func setup() async -> Void {
        
        do {
            let docRef = Database.store.collection("users").document(user!.uid as String)
            let document = try await docRef.getDocument()
            if document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                coins = document.data()?["points"] as! Int
                rank = document.data()?["rank"] as! Int
                name = document.data()?["name"] as! String
                print(name)
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist for user: \(user!.uid)")
            }
        } catch {
            print("Error getting documents: \(error)")
        }
    }
    
}
