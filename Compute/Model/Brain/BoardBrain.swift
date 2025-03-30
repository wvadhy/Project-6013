import Foundation

struct BoardBrain {
    
    static var shared = BoardBrain()
    
    func getPlayers() async -> [BoardData] {
        do {
            var storage: [BoardData] = []
            let querySnapshot = try await Database.store.collection("users").getDocuments()
            for document in querySnapshot.documents {
                storage.append(BoardData(name: document.data()["name"] as! String,
                                         points: document.data()["pointsTotal"] as! Int))
            }
            storage.sort(by: {$0.points > $1.points})
            return storage
        } catch {
            print("Error getting documents: \(error)")
            return []
        }
    }
    
    func getPlayerCount() async -> Int {
        let query = Database.store.collection("users")
        let countQuery = query.count
        do {
            let snapshot = try await countQuery.getAggregation(source: .server)
            print(Int(truncating: snapshot.count))
            return Int(truncating: snapshot.count)
        } catch {
            print(error)
            return 1
        }
    }
    
}
