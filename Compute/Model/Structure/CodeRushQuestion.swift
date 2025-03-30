import Foundation
import OpenAI

struct CodeRushQuestion: StructuredOutput {
    let question: String
    let answer_one: String
    let answer_two: String
    let correct_answer: String
    
    static let example: Self = {
        .init(
            question: "question",
            answer_one: "incorrect",
            answer_two: "incorrect",
            correct_answer: "correct"
        )
    }()
}
