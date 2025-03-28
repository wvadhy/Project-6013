import Foundation
import FirebaseFirestore

struct DeepDiveBrain {
    
    static var shared = DeepDiveBrain()
        
    init() {}
    
    func getQuestion(for lang: String) async -> String {
        do {
            let result = try await LLM.ai.getDeepDive(for: lang)
            let object = result.choices[0].message.content?.string!
            return object!
        } catch {
            print("Error: \(error)")
            return "Error: \(error)"
        }
    }
    
//    func updateEntries() async -> Void {
//        let docRef = Database.store.collection("users").document(UserData.shared.user!.uid)
//        do {
//            try await docRef.updateData([
//                "deepDiveTotal": FieldValue.increment(Int64(total)),
//                "deepDiveAverage": Int(average)!,
//                "deepDiveHighScore": total > Int(currenHighScore)! ? correct : Int(currenHighScore)!,
//                "totalGamesPlayed": FieldValue.increment(Int64(1.0)),
//                "gold": FieldValue.increment(Int64(44.0)),
//                "pointsTotal": FieldValue.increment(Int64(total))
//            ])
//            print("Document successfully updated")
//        } catch {
//            print("Error updating document: \(error)")
//        }
//    }
    
    func analyseAnswer(for lang: String, with code: String) async -> DeepDiveAnalysisList {
        do {
            print("Getting analysis...")
            
            let result = try await LLM.ai.analyseDeepDive(for: lang, with: code)
            
            print("Converting to JSON...")
            
            let json = result.choices[0].message.content?.string?.data(using: .utf8)
            
            print("Parsing data...")
            
            let toParse = try JSONDecoder().decode(DeepDiveAnalysisList.self, from: json!)
            
            return toParse
        } catch {
            print("Error: \(error)")
            return DeepDiveAnalysisList(analysis: [], score: 0)
        }
    }
    
}
