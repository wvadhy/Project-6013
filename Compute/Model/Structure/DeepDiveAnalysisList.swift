import Foundation
import OpenAI

struct DeepDiveAnalysisList: StructuredOutput {
    
    let analysis: [DeepDiveAnalysis]
    let score: Int
    
    static let example: Self = {
        .init(
            analysis: [DeepDiveAnalysis(
                positive: "The code showcased good understanding of the language with no logical errors",
                negative: "The code was not well structured and is too long"
            )],
            score: 78
        )
    }()
}
