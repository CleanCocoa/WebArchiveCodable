import XCTest
@testable import WebArchiveCodable

final class WebArchiveCodableTests: XCTestCase {
    func test_AdeleFixture() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "adele-for-vogue-in-2021", withExtension: "webarchive", subdirectory: "Fixtures"))
        let data = try Data(contentsOf: url)
        let webArchive = try PropertyListDecoder().decode(WebArchive.self, from: data)

        XCTAssertEqual(webArchive, WebArchive(
            mainResource: .init(mimeType: "text/html"),
            subresources: [
                .init(mimeType: "image/png"),
            ]))
    }
}
