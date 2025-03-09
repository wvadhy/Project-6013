import Foundation
import OpenAI

struct CodeRushQuestion: StructuredOutput {
    let question: String
    let answer_one: String
    let answer_two: String
    let answer_three: String
    let correct_answer: String
    
    static let example: Self = {
        .init(
            question: "How do you make a list?",
            answer_one: "list()",
            answer_two: "dict()",
            answer_three: "set()",
            correct_answer: "list()"
        )
    }()
}
