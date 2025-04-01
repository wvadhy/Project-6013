import Foundation
import FirebaseFirestore

class DeepDiveBrain {
    
    static var shared = DeepDiveBrain()
    
    var current: [DeepDiveQuestion] = []
    var points: Int = 0
    var difficulty: Int = 1
        
    init() {}
    
    func getHelp() async -> String {
        do {
            let result = try await LLM.ai.getHelp(for: current[0].code, with: current[0].question)
            return result.choices[0].message.content?.string ?? "Error: invalid response"
        } catch {
            print("Error: \(error)")
            return "error"
        }
    }
    
    func getQuestion(for lang: String) async -> [DeepDiveQuestion] {
        do {
            print("Getting questions...")
            let result = try await LLM.ai.getDeepDiveQuestion(for: lang)
            
            print("Converting to JSON...")
            
            let json = result.choices[0].message.content?.string?.data(using: .utf8)
            
            print("Parsing data...")
            
            let toParse = try JSONDecoder().decode(DeepDiveQuestion.self, from: json!)
            
            print("Sucessfully obtained questions!")
            current = [toParse]
            return [toParse]
        } catch {
            print("Error: \(error)")
            return []
        }
    }
    
    func updatePoints(for score: Int) -> Void {
        Task {
            let rank = await UserData.shared.query(for: "rank")
            points += (2 * (Int(rank) ?? 1) * difficulty) + score
        }
    }
    
    func reset() -> Void {
        current = []
    }
    
//    func getQuestion(for lang: String) async -> String {
//        do {
//            let result = try await LLM.ai.getDeepDive(for: lang)
//            let object = result.choices[0].message.content?.string!
//            return object!
//        } catch {
//            print("Error: \(error)")
//            return "Error: \(error)"
//        }
//    }
    
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
