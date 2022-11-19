#if os(macOS)
import AppKit

extension WebArchive {
    public init?(from pasteboard: NSPasteboard) throws {
        guard let data = pasteboard.data(forType: .Legacy._AppleWebArchivePasteboardType)
                ?? pasteboard.data(forType: .Legacy._webarchive)
        else { return nil }
        self = try PropertyListDecoder().decode(WebArchive.self, from: data)
    }
}

extension NSPasteboard.PasteboardType {
    enum Legacy {
        static let _AppleWebArchivePasteboardType = NSPasteboard.PasteboardType("Apple Web Archive pasteboard type")

        static let _webarchive: NSPasteboard.PasteboardType = NSPasteboard.PasteboardType(rawValue: "com.apple.webarchive")

    }
}
#endif
