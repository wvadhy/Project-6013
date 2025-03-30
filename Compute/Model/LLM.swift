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
    
    func tokenObtained(_ token: Token) {
        self.model = OpenAI(apiToken: token.key)
    }
        
    func tokenFailed(_ error: any Error) { print("Error: \(String(describing: error))") }
    
    public func getChat(for msg: String ) async throws -> ChatResult {
        let query = ChatQuery(messages: [.system(.init(content: "\(msg), \(Context.shared.body)"))], model: .gpt4_o)
        return try await model.chats(query: query)
    }
    
    public func getCodeRush(for lang: String) async throws -> ChatResult {
        let query = ChatQuery(messages: [.system(.init(content: "10 short \(lang) questions"))],
                              model: .gpt4_o,
                              responseFormat: .jsonSchema(name: "crql", type: CodeRushQuestionList.self))
        return try await model.chats(query: query)
    }
    
    public func getDeepDive(for lang: String) async throws -> ChatResult {
        let query = ChatQuery(messages: [.init(role: .user, content: "Give me a \(lang) erroneous code snippet which needs to be fixed and no other text as raw text with no markups, no highlighting, no backticks")!], model: .gpt4_o)
        return try await model.chats(query: query)
    }
    
    public func analyseDeepDive(for lang: String, with code: String) async throws -> ChatResult {
        let query = ChatQuery(messages: [.system(.init(content: "Give 5 positives and negatives and a score for this \(lang) code: \(code)"))],
                              model: .gpt4_o,
                              responseFormat: .jsonSchema(name: "ddas", type: DeepDiveAnalysisList.self))
        return try await model.chats(query: query)
    }

    
}
