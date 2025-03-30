import Foundation

class ChatBrain {
    
    static let shared: ChatBrain = ChatBrain()
    
    func fetchResponse(for message: String) async -> String {
        
        do {
            let result = try await LLM.ai.getChat(for: message)
            return result.choices[0].message.content?.string ?? "Error: invalid response"
        } catch {
            print(error)
            return "Error: \(error)"
        }
    }
    
}
