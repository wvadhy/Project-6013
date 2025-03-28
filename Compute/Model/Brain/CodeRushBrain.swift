import Foundation
import FirebaseFirestore
import OpenAI
import UIKit

struct CodeRushBrain {
    
    static var shared = CodeRushBrain()
    
    var initProg: Float = 0.0
    var copyProg: Float = 0.0
    var correct: Int = 0
    var total: Int = 0
    let numQuestions: Int = 10
    
    init() {
        self.initProg = 1.0 / Float(numQuestions)
        self.copyProg = initProg
    }
    
    mutating func pressed(_ text: String) -> Float {
        initProg += copyProg
        return initProg;
    }
    
    mutating func getQuestions(for lang: String) async -> [CodeRushQuestion] {
        do {
            print("Getting questions...")
            let result = try await LLM.ai.getCodeRush(for: lang)
            
            print("Converting to JSON...")
            
            let json = result.choices[0].message.content?.string?.data(using: .utf8)
            
            print("Parsing data...")
            
            let toParse = try JSONDecoder().decode(CodeRushQuestionList.self, from: json!)
            
            print("Sucessfully obtained questions!")
            return toParse.questions
        } catch {
            print("Error: \(error)")
            return []
        }
    }
    
    mutating func badAnswer() -> Void {
        total += 1
    }
    
    mutating func goodAnswer() -> Void {
        total += 1
        correct += 1
    }
    
    private func calculateAverage() async -> String {
        let totalCorrect = await UserData.shared.query(for: "codeRushCorrect")
        let total = await UserData.shared.query(for: "codeRushTotal")
        let games = await UserData.shared.query(for: "codeRushPlayed")
        
        let result = (Int(total)! - Int(totalCorrect)!) / Int(games)!
        
        return "\(result)"
        
    }
    
    func getAverage() async -> String {
        let average = await UserData.shared.query(for: "codeRushAverage")
        return average
    }
    
    func getHighScore() async -> String {
        let highScore = await UserData.shared.query(for: "codeRushHighScore")
        return highScore
    }
    
    func getTotalCorrect() async -> String {
        let totalCorrect = await UserData.shared.query(for: "codeRushCorrect")
        return totalCorrect
    }
    
    func getTotal() async -> String {
        let total = await UserData.shared.query(for: "codeRushTotal")
        return total
    }
    
    
    func updateEntries() async -> Void {
        let docRef = Database.store.collection("users").document(UserData.shared.user!.uid)
        do {
            let average = await calculateAverage()
            let currenHighScore = await getHighScore()
            let rank = await UserData.shared.query(for: "rank")
            try await docRef.updateData([
                "codeRushTotal": FieldValue.increment(Int64(total)),
                "codeRushAverage": Int(average)!,
                "codeRushHighScore": correct > Int(currenHighScore)! ? correct : Int(currenHighScore)!,
                "totalGamesPlayed": FieldValue.increment(Int64(1.0)),
                "gold": FieldValue.increment(Int64(1.0)),
                "pointsTotal": FieldValue.increment(Int64(total))
            ])
            print("Document successfully updated")
        } catch {
            print("Error updating document: \(error)")
        }
    }
}
