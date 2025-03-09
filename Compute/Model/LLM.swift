import Foundation
import OpenAI

class LLM: LLMDelegate {
    
    static var ai = LLM()
    
    var network = LLMNetwork()
    
    let url = URL(string: "https://computex.cloud/data/HD8qogh8O7HDo8ydhgoUJDS.json")!
    
    var model = OpenAI(apiToken: "")
    
    init() {
        network.delegate = self
        network.getData(from: url) { (ouput) in print("Sucessfully obtained key!") }
    }
    
    func tokenObtained(_ token: Token) { self.model = OpenAI(apiToken: token.key) }
        
    func tokenFailed(_ error: any Error) { print("Error: \(String(describing: error))") }
    
    public func getCodeRush(for lang: String) async throws -> ChatResult {
        let query = ChatQuery(messages: [.system(.init(content: "10 \(lang) questions"))],
                              model: .gpt4_o,
                              responseFormat: .jsonSchema(name: "movie-info", type: CodeRushQuestionList.self))
        return try await model.chats(query: query)
    }
    
    public func getDeepDive(for lang: String) async throws -> ChatResult {
        let query = ChatQuery(messages: [.init(role: .user, content: "Give me a \(lang) code snippet which needs to be refactored and no other text as raw text with no markups, no highlighting, no backticks")!], model: .gpt4_o)
        return try await model.chats(query: query)
    }
    
    public func analyseDeepDive(for lang: String, with code: String) async throws -> ChatResult {
        let query = ChatQuery(messages: [.init(role: .user, content: "Please give me feedback for this \(lang) code snippet and no other text as raw text with no markups, no highlighting, no backticks: \(code)")!], model: .gpt4_o)
        return try await model.chats(query: query)
    }

    
}
