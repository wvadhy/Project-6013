import Foundation

struct DeepDiveBrain {
    
    static var shared = DeepDiveBrain()
    
    let llm: LLM
    
    init() {
        llm = LLM()
    }
    
    func getQuestion(for lang: String) async -> String {
        do {
            let result = try await llm.getDeepDive(for: lang)
            let object = result.choices[0].message.content?.string!
            return object!
        } catch {
            print("Error: \(error)")
            return "Error: \(error)"
        }
    }
    
    func analyseAnswer(for lang: String, with code: String) async -> String {
        do {
            let result = try await llm.analyseDeepDive(for: lang, with: code)
            let object = result.choices[0].message.content?.string!
            return object!
        } catch {
            print("Error: \(error)")
            return "Error: \(error)"
        }
    }
    
}
