import Foundation

public struct WebArchive: Equatable {
    public struct WebResource: Equatable {
        public let mimeType: String
        public let url: URL?
        public let frameName: String?
    }

    public let mainResource: WebResource
    public let subresources: [WebResource]?
}

extension WebArchive.WebResource: Decodable {
    enum CodingKeys: String, CodingKey {
        case MIMEType = "WebResourceMIMEType"
        case url = "WebResourceURL"
        case frameName = "WebResourceFrameName"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            mimeType: container.decode(String.self, forKey: .MIMEType),
            url: container.decodeIfPresent(String.self, forKey: .url)
                .flatMap(URL.init(string:)),
            frameName: container.decodeIfPresent(String.self, forKey: .frameName)
        )
    }
}

extension WebArchive: Decodable {
    enum CodingKeys: String, CodingKey {
        case mainResource = "WebMainResource"
        case subresources = "WebSubresources"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            mainResource: container.decode(WebResource.self, forKey: .mainResource),
            subresources: container.decodeIfPresent(Array<WebResource>.self, forKey: .subresources)
        )
    }
}
