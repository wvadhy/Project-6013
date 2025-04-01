import Foundation

class FeedbackBrain {
    
    static var shared: FeedbackBrain = FeedbackBrain()
    
    var weakness: String = ""
    var strength: String = ""
    var todo: String = ""
    
    init() {
        Task {
            strength = await getStrengths()
            weakness = await getWeakness()
            todo = await getImprovements()
        }
    }
    
    func getStrengths() async -> String {
        do {
            let result = try await LLM.ai.getStrengths()
            return result.choices[0].message.content?.string ?? "Error: invalid response"
        } catch {
            print("Error \(error)")
            return "error"
        }
    }
    
    func getWeakness() async -> String {
        do {
            let result = try await LLM.ai.getWeakness()
            return result.choices[0].message.content?.string ?? "Error: invalid response"
        } catch {
            print("Error \(error)")
            return "error"
        }
    }
    
    func getImprovements() async -> String {
        do {
            let result = try await LLM.ai.getImprovements()
            return result.choices[0].message.content?.string ?? "Error: invalid response"
        } catch {
            print("Error \(error)")
            return "error"
        }
    }
    
}
