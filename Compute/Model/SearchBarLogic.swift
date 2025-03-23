import Foundation

class SearchBarLogic {
    
    func resolveQuery(for name: String) async -> StatsData {

        do {
            print("progress")
            let querySnapshot = try await Database.store.collection("users").whereField("name", isEqualTo: name)
                .getDocuments()
            if(!querySnapshot.documents.isEmpty) {
                let user = StatsData()
                user.createData(for: querySnapshot.documents[0])
                return user
            }
        } catch {
            print("Error getting document: \(error)")
            return StatsData()
        }
        
        return StatsData()
    }
    
}
