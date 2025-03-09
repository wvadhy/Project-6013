import Foundation

import OpenAI

struct CodeRushQuestionList: StructuredOutput {
    let questions: [CodeRushQuestion]
    
    static let example: Self = {
        .init(
            questions: [CodeRushQuestion(question: "How do you make a dict?",
                                         answer_one: "list()",
                                         answer_two: "dict()",
                                         answer_three: "set()",
                                         correct_answer: "dict()")]
        )
    }()
}
