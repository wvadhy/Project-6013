import Foundation
import OpenAI

struct DeepDiveAnalysis: StructuredOutput {
    
    let analysis: String
    let score: Int
    
    static let example: Self = {
        .init(
            analysis: "The code was not well structured and presented some logical errors impairing functionality",
            score: 18
        )
    }()
}
