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
            question: "Question",
            answer_one: "AnswerOne",
            answer_two: "AnswerTwo",
            answer_three: "AnswerThree",
            correct_answer: "AnswerTwo"
        )
    }()
}
