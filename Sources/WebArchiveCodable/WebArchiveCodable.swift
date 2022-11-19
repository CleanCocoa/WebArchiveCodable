public struct WebArchive: Equatable {
    public struct WebResource: Equatable {
        public let mimeType: String
    }

    public let mainResource: WebResource
    public let subresources: [WebResource]?
}

extension WebArchive.WebResource: Decodable {
    enum CodingKeys: String, CodingKey {
        case MIMEType = "WebResourceMIMEType"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            mimeType: container.decode(String.self, forKey: .MIMEType)
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
            subresources: container.decode(Optional<Array<WebResource>>.self, forKey: .subresources)
        )
    }
}
