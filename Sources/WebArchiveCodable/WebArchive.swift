import Foundation

/// Represents a web site that can be archived.
///
/// Web content is archived for example on disk when saving web pages from Safari, and on the pasteboard when copying data.
///
/// The ``mainResource`` can be, for example,
/// - an entire page,
/// - a portion of a web page,
/// - other data like an image.
///
/// For the legacy Objective-C version, see <https://developer.apple.com/documentation/webkit/webarchive> which was deprecated for macOS 10.14.
///
/// ## Codable content
///
/// Use `PropertyListDecoder` to decode `.webarchive` files or `Data` from a `NSPasteboard` with the `"Apple Web Archive pasteboard type"` or "`com.apple.webarchive"` pasteboard types.
public struct WebArchive {
    /// Represents a downloaded resource.
    ///
    /// A ``Resource`` encapsulates the data of the download as well as associated resource properties such as the URL, MIME type, and frame name.
    ///
    /// Confer WebKit's `WebResource.h`:  <https://github.com/WebKit/WebKit/blob/main/Source/WebKitLegacy/win/WebResource.h>
    ///
    /// For the Objective-C version, see <https://developer.apple.com/documentation/webkit/webresource> -- which notably was not deprecated with `WebArchive`.
    public struct Resource {
        /// The downloaded data.
        public let data: Data?

        /// The downloaded resource's orignal URL.
        public let url: URL?

        /// The downloaded resource's MIME type.
        public let mimeType: String

        /// The IANA encoding name (for example, "UTF-8" or "UTF-16"), or `nil` if text encoding is not applicable (e.g. for image subresources).
        public let textEncodingName: String?

        /// The name of the frame.
        ///
        /// If the receiver does not represent the contents of an entire HTML frame, returns `nil`.
        public let frameName: String?
    }

    /// The receiver's main resource.
    public let mainResource: Resource

    /// The receiver's subresources, or `nil` if there are none.
    public let subresources: [Resource]?
}

extension WebArchive.Resource: Decodable {
    enum CodingKeys: String, CodingKey {
        case data = "WebResourceData"
        case url = "WebResourceURL"
        case MIMEType = "WebResourceMIMEType"
        case textEncodingName = "WebResourceTextEncodingName"
        case frameName = "WebResourceFrameName"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            data: container.decodeIfPresent(Data.self, forKey: .data),
            url: container.decodeIfPresent(String.self, forKey: .url)
                    .flatMap(URL.init(string:)),
            mimeType: container.decode(String.self, forKey: .MIMEType),
            textEncodingName: container.decodeIfPresent(String.self, forKey: .textEncodingName),
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
