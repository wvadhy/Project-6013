import Foundation

struct LLMNetwork {
    
    var delegate: LLMDelegate?
    
    init(){}
    
    public func getData(from url: URL, completion handler: @escaping (Token) -> Void) -> Void {
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            
            guard let data = $0, $2 == nil else {
                print("Something went wrong...")
                return
            }
            
            var response: Token?
            
            do {
                response = try JSONDecoder().decode(Token.self, from: data)
            } catch {
                delegate?.tokenFailed($2!)
            }
            
            guard let json = response else {return}
            
            delegate?.tokenObtained(json)
            
            handler(json)
    
        })
        
        task.resume()
    }
    
}
