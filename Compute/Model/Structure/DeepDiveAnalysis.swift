import Foundation
import OpenAI

struct DeepDiveAnalysis: StructuredOutput {
    
    let positive: String
    let negative: String
    
    static let example: Self = {
        .init(
            positive: "The code showcased good understanding of the language and semantics with no clear logical errors",
            negative: "The code was not well structured and is too long"
        )
    }()
}
