import NIOCore
import NIOHTTP1
import NIOPosix
import Foundation

struct LLMNetwork {
    
    var delegate: LLMDelegate?
    
    let group: MultiThreadedEventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    
    let bootstrap: ClientBootstrap
        
    init(){
        bootstrap = ClientBootstrap(group: group)
        .channelOption(.socketOption(.so_reuseaddr), value: 1)
        .channelInitializer { channel in
            channel.eventLoop.makeCompletedFuture {
                try channel.pipeline.syncOperations.addHTTPClientHandlers(
                    position: .first,
                    leftOverBytesStrategy: .fireError
                )
                try channel.pipeline.syncOperations.addHandler(HTTPEchoHandler())
            }
        }
        defer {
            try! group.syncShutdownGracefully()
        }
    }
    
    public func getData(from url: URL, completion handler: @escaping (Token) -> Void) -> Void {
        
        let target: ConnectTo = .ip(host: url.absoluteString, port: 8888)
        
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
