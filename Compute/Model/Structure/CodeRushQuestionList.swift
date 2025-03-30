import Foundation

import OpenAI

struct CodeRushQuestionList: StructuredOutput {
    let questions: [CodeRushQuestion]
    
    static let example: Self = {
        .init(
            questions: [CodeRushQuestion(question: "Question",
                                         answer_one: "AnswerOne",
                                         answer_two: "AnswerTwo",
                                         answer_three: "AnswerThree",
                                         correct_answer: "AnswerOne")]
        )
    }()
}
