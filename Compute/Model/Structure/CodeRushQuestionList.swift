import Foundation

import OpenAI

struct CodeRushQuestionList: StructuredOutput {
    let questions: [CodeRushQuestion]
    
    static let example: Self = {
        .init(
            questions: [CodeRushQuestion(question: "question",
                                         answer_one: "incorrect",
                                         answer_two: "incorrect",
                                         correct_answer: "correct")]
        )
    }()
}
