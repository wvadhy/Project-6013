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
    
    public func getFeedback(for score: String, outof total: String = "10") async throws -> ChatResult {
        let query = ChatQuery(messages: [.system(.init(content: "Give a short sentence of encouragment for a \(score)/\(total) on a programming quiz"))], model: .gpt4_o)
        return try await model.chats(query: query)
    }
    
    public func getImprovements() async throws -> ChatResult {
        let query = ChatQuery(messages: [.system(.init(content: "Give me a small paragraph breakdown of how to improve my task scores, \(Context.shared.body)"))], model: .gpt4_o)
        return try await model.chats(query: query)
    }
    
    public func getWeakness() async throws -> ChatResult {
        let query = ChatQuery(messages: [.system(.init(content: "Give me me a small paragraph breakdown of what my weaknesses are, \(Context.shared.body)"))], model: .gpt4_o)
        return try await model.chats(query: query)
    }
    
    public func getStrengths() async throws -> ChatResult {
        let query = ChatQuery(messages: [.system(.init(content: "Give me a small paragraph breakdown of what my strengths are, \(Context.shared.body)"))], model: .gpt4_o)
        return try await model.chats(query: query)
    }
    
    public func getChat(for msg: String ) async throws -> ChatResult {
        let query = ChatQuery(messages: [.system(.init(content: "\(msg), \(Context.shared.body)"))], model: .gpt4_o)
        return try await model.chats(query: query)
    }
    
    public func getHelp(for code: String, with quest: String) async throws -> ChatResult {
        let query = ChatQuery(messages: [.system(.init(content: "Give me a short tip but no code for how to solve: \(quest), my current code: \(code)"))], model: .gpt4_o)
        return try await model.chats(query: query)
    }
    
    public func getDeepDiveQuestion(for lang: String, with difficulty: String = "easy") async throws -> ChatResult {
        let query = ChatQuery(messages: [.system(.init(content: "A short, \(difficulty) \(lang) programming problem with a question that is under 25 words long, example, single line input, single line output, constraints, incorrect code snippet with no comments and solution code"))],
                              model: .gpt4_o,
                              responseFormat: .jsonSchema(name: "ddqs", type: DeepDiveQuestion.self))
        return try await model.chats(query: query)
    }
    
    public func getCodeRush(for lang: String, with difficulty: String = "easy") async throws -> ChatResult {
        let query = ChatQuery(messages: [.system(.init(content: "10 short \(difficulty) \(lang) questions with short answers"))],
                              model: .gpt4_o,
                              responseFormat: .jsonSchema(name: "crql", type: CodeRushQuestionList.self))
        return try await model.chats(query: query)
    }
    
    public func getDeepDive(for lang: String) async throws -> ChatResult {
        let query = ChatQuery(messages: [.init(role: .user, content: "Give me a \(lang) erroneous code snippet which needs to be fixed and no other text as raw text with no markups, no highlighting, no backticks")!], model: .gpt4_o)
        return try await model.chats(query: query)
    }
    
    public func analyseDeepDive(for lang: String, with code: String, using question: String) async throws -> ChatResult {
        let query = ChatQuery(messages: [.system(.init(content: "Give 5 positives and negatives which are each less than 10 words and a score for this \(lang) code which is trying to answer the question '\(question)': \(code)"))],
                              model: .gpt4_o,
                              responseFormat: .jsonSchema(name: "ddas", type: DeepDiveAnalysisList.self))
        return try await model.chats(query: query)
    }

    
}
