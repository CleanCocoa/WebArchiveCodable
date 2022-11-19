import Foundation

public struct WebArchive {
    /// Represents a downloaded URL.
    ///
    /// A ``Resource`` encapsulates the data of the download as well as associated resource properties such as the URL, MIME type, and frame name.
    ///
    /// Confer WebKit's `WebResource.h`:  <https://github.com/WebKit/WebKit/blob/main/Source/WebKitLegacy/win/WebResource.h>
    public struct Resource {
        public let url: URL?

        public let mimeType: String

        public let data: Data?
        public let frameName: String?
    }

    public let mainResource: Resource
    public let subresources: [Resource]?
}

extension WebArchive.Resource: Decodable {
    enum CodingKeys: String, CodingKey {
        case url = "WebResourceURL"
        case MIMEType = "WebResourceMIMEType"
        case data = "WebResourceData"
        case frameName = "WebResourceFrameName"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            url: container.decodeIfPresent(String.self, forKey: .url)
                    .flatMap(URL.init(string:)),
            mimeType: container.decode(String.self, forKey: .MIMEType),
            data: container.decodeIfPresent(Data.self, forKey: .data),
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
            mainResource: container.decode(Resource.self, forKey: .mainResource),
            subresources: container.decodeIfPresent(Array<Resource>.self, forKey: .subresources)
        )
    }
}
