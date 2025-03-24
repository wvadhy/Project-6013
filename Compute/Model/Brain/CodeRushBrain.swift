import Foundation
import OpenAI
import UIKit

struct CodeRushBrain {
    
    static var shared = CodeRushBrain()
    
    var initProg: Float = 0.0
    var copyProg: Float = 0.0
    var correct: Int = 0
    var total: Int = 0
    var numQuestions: Int = 10
    
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
    
    mutating func badAnswer() -> Void { total += 1 }
    
    mutating func goodAnswer() -> Void { correct += 1 }
    
    func calculateAverage() -> Double { return /*Double(scores.reduce(0, +) / scores.count)*/ 0.1 }
    
    func calculateHighScore() -> Int { return 1 }
    
    func calculateTotalCorrect() -> Int { return 1 }
    
    func calculateTotalIncorrect() -> Int { return 1 }
    
    
    mutating func feedback() -> String {
        if (correct > 5) {
            correct = 0
            total = 0
            return "Good job, you did better than most!"
        } else {
            correct = 0
            total = 0
            return "Maybe some more practice next time!"
        }
    }
}
