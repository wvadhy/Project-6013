import Foundation

protocol LLMDelegate {
    func tokenObtained(_ token: Token)
    func tokenFailed(_ error: Error)
}
