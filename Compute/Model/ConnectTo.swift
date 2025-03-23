import Foundation

enum ConnectTo {
    case ip(host: String, port: Int)
    case unixDomainSocket(path: String)
}
