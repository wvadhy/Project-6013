import Foundation
import OpenAI

struct DeepDiveAnalysis: StructuredOutput {
    
    let positive: String
    let negative: String
    
    static let example: Self = {
        .init(
            positive: "There were no logical errors",
            negative: "Should use a dict instead of a list"
        )
    }()
}
