import Foundation
import FirebaseFirestore
import FirebaseAuth

class StatsData {
    
    var rank: Int = 0
    var name: String = ""
    var points: Int = 0
    var gamesPlayed: Int = 0
    var validated: Bool = false
    
    init(){}
    
    public func createData(for user: DocumentSnapshot) -> Void {
        
        if user.exists {
            let dataDescription = user.data().map(String.init(describing:)) ?? "nil"
            rank = user.data()?["rank"] as! Int
            name = user.data()?["name"] as! String
            points = user.data()?["pointsTotal"] as! Int
            gamesPlayed = user.data()?["totalGamesPlayed"] as! Int
            validated = true
            print("Document data: \(dataDescription)")
        } else {
            print("Document does not exist for user: \(user)")
        }
    }
    
}
