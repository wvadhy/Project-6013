import NIOCore
import NIOHTTP1
import NIOPosix

public final class HTTPEchoHandler: ChannelInboundHandler {
    
    public typealias InboundIn = HTTPClientResponsePart
    public typealias OutboundOut = HTTPClientRequestPart

    public func channelActive(context: ChannelHandlerContext) {
        print("Compute has connected to \(context.remoteAddress!)!")

        let buffer = context.channel.allocator.buffer(string: "getToken")

        var headers = HTTPHeaders()
        headers.add(name: "Content-Type", value: "text/plain; charset=utf-8")
        headers.add(name: "Content-Length", value: "\(buffer.readableBytes)")

        let requestHead = HTTPRequestHead(
            version: .http1_1,
            method: .GET,
            uri: "/data/token",
            headers: headers
        )

        context.write(Self.wrapOutboundOut(.head(requestHead)), promise: nil)

        context.write(Self.wrapOutboundOut(.body(.byteBuffer(buffer))), promise: nil)

        context.writeAndFlush(Self.wrapOutboundOut(.end(nil)), promise: nil)
    }

    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {

        let clientResponse = Self.unwrapInboundIn(data)

        switch clientResponse {
        case .head(let responseHead):
            print("Received status: \(responseHead.status)")
        case .body(let byteBuffer):
            let string = String(buffer: byteBuffer)
            print("Received: '\(string)' back from the server.")
        case .end:
            print("Closing channel.")
            context.close(promise: nil)
        }
    }

    public func errorCaught(context: ChannelHandlerContext, error: Error) {
        print("error: ", error)
        context.close(promise: nil)
    }
}
