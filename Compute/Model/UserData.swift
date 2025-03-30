import Foundation
import FirebaseFirestore
import FirebaseAuth

struct UserData {
    
    var user: User?
    var name: String = ""
    
    static var shared: UserData = UserData(for: Auth.auth().currentUser!)
    
    init(for person: User?) {
        print("Creating user data for: \(String(describing: person?.email))")
        user = person
        print(user?.uid)
    }
    
    public func query(for name: String) async -> String {
        do {
            let docRef = Database.store.collection("users").document(user!.uid as String)
            let document = try await docRef.getDocument()
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            if document.exists {
                if var item = document.data()?[name] {
                    if item is Int {
                        item = item as! Int
                    } else if item is Double {
                        item = item as! Double
                    }
                    return "\(item)"
                } else {
                    print("Data does not exist for document: \(dataDescription)")
                }
            } else {
                print("Document does not exist for user: \(user!.uid)")
            }
        } catch {
            print("Error getting documents: \(error)")
        }
        return ""
    }
    
}
