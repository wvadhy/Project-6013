import Foundation
import FirebaseFirestore

class DeepDiveBrain {
    
    static var shared = DeepDiveBrain()
    
    var current: [DeepDiveQuestion] = []
    var points: Int = 0
    var difficulty: Int = 1
    var score: Int = 0
    var played: Int = 0
    var high: Int = 0
    var accuracy: Int = 0
    var total: Int = 0
        
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
        
        updateScores()
        
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
    
    func getHighScore() async -> String {
        return await UserData.shared.query(for: "deepDiveHighScore")
    }
    
    func getAverage() async -> String {
        return await UserData.shared.query(for: "deepDiveAverage")
    }
    
    func updateScores() -> Void {
        score += 2 * difficulty
        played += 1
        total += 100
    }
    
    func updatePoints(for score: Int) -> Void {
        Task {
            let rank = await UserData.shared.query(for: "rank")
            points += (2 * (Int(rank) ?? 1) * difficulty) + score
        }
    }
    
    func updateHighScore(for score: Int) -> Void {
        high = score > high ? score: high
    }
    
    func reset() -> Void {
        current = []
    }
    
    func end() -> Void {
        score = 0
        points = 0
        played = 0
        high = 0
    }
    
    private func calculateAverage() async -> String {
        let totalCorrect = await UserData.shared.query(for: "deepDiveCorrect")
        let total = await UserData.shared.query(for: "deepDiveTotal")
        let games = await UserData.shared.query(for: "deepDivePlayed")
        
        let result = (Int(total)! - Int(totalCorrect)!) / Int(games)!
        
        return "\(result)"
        
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
    
    func updateEntries() async -> Void {
        let docRef = Database.store.collection("users").document(UserData.shared.user!.uid)
        let currentHighScore = await UserData.shared.query(for: "deepDiveHighScore")
        let average = await calculateAverage()
        do {
            try await docRef.updateData([
                "deepDiveTotal": FieldValue.increment(Int64(played)),
                "deepDiveAverage": Int(average)!,
                "deepDiveHighScore": high > Int(currentHighScore)! ? high : Int(currentHighScore)!,
                "totalGamesPlayed": FieldValue.increment(Int64(1.0)),
                "gold": FieldValue.increment(Int64(points)),
                "pointsTotal": FieldValue.increment(Int64(score))
            ])
            print("Document successfully updated")
        } catch {
            print("Error updating document: \(error)")
        }
    }
    
    func generateFeedback() async -> String {
        do {
            let result = try await LLM.ai.getFeedback(for: "\(score)", outof: "\(total)")
            return result.choices[0].message.content?.string ?? "Error: invalid response"
        } catch {
            print("Error: \(error)")
            return "error"
        }
    }
    
    func analyseAnswer(for lang: String, with code: String) async -> DeepDiveAnalysisList {
        do {
            print("Getting analysis...")
            
            let result = try await LLM.ai.analyseDeepDive(for: lang, with: code, using: current[0].question)
            
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
