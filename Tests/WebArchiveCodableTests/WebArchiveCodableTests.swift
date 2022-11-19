import XCTest
@testable import WebArchiveCodable

final class WebArchiveCodableTests: XCTestCase {
    func test_AdeleFixture() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "adele-for-vogue-in-2021", withExtension: "webarchive", subdirectory: "Fixtures"))
        let data = try Data(contentsOf: url)
        let webArchive = try PropertyListDecoder().decode(WebArchive.self, from: data)

        XCTAssertEqual(webArchive, WebArchive(
            mainResource: .init(
                mimeType: "text/html",
                url: URL(string: "https://en.wikipedia.org/wiki/Main_Page#/media/File:Adele_for_Vogue_in_2021.png")!
            ),
            subresources: [
                .init(mimeType: "image/png",
                      url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/5/52/Adele_for_Vogue_in_2021.png")!),
            ]))
    }
}
