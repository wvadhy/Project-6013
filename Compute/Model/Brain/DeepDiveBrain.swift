import Foundation

struct DeepDiveBrain {
    
    static var shared = DeepDiveBrain()
        
    init() {}
    
    func getQuestion(for lang: String) async -> String {
        do {
            let result = try await LLM.ai.getDeepDive(for: lang)
            let object = result.choices[0].message.content?.string!
            return object!
        } catch {
            print("Error: \(error)")
            return "Error: \(error)"
        }
    }
    
    func analyseAnswer(for lang: String, with code: String) async -> [DeepDiveAnalysis] {
        do {
            print("Getting analysis...")
            
            let result = try await LLM.ai.analyseDeepDive(for: lang, with: code)
            
            print("Converting to JSON...")
            
            let json = result.choices[0].message.content?.string?.data(using: .utf8)
            
            print("Parsing data...")
            
            let toParse = try JSONDecoder().decode(DeepDiveAnalysis.self, from: json!)
            
            return [toParse]
        } catch {
            print("Error: \(error)")
            return []
        }
    }
    
}
