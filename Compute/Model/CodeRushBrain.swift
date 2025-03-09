import Foundation
import OpenAI
import UIKit

struct CodeRushBrain {
    
    static var shared = CodeRushBrain()
    
    var initProg: Float = 0.0
    var copyProg: Float = 0.0
    var correct = 0
    var totalCorrect = 0
    var totalTotal = 0
    var total = 0
    var highScore = 0
    var scores: [Int] = [0]
    var average: Double = 0.0
    
    let numQuestions = 10
    let url = URL(string: "https://computex.cloud/data/api.json")!
    let llm: LLM
    
    init() {
        self.initProg = 1.0 / Float(numQuestions)
        self.copyProg = initProg
        llm = LLM()
    }
    
    mutating func pressed(_ text: String) -> Float {
        initProg += copyProg
        return initProg;
    }
    
    mutating func getQuestions(for lang: String) async -> [CodeRushQuestion] {
        do {
            print("Getting questions...")
            let result = try await llm.getCodeRush(for: lang)
            
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
    
    mutating func calculateAverage() -> Double { return Double(scores.reduce(0, +) / scores.count) }
    
    mutating func calculateHighScore() -> Void {
        scores.append(correct)
        totalCorrect += correct
        totalTotal += total
        if (correct > highScore) {
            highScore = correct
        }
    }
    
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
