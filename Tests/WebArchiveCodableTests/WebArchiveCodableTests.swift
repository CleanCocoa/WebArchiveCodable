import XCTest
@testable import WebArchiveCodable

final class WebArchiveCodableTests: XCTestCase {
    func test_AdeleFixture() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "adele-for-vogue-in-2021", withExtension: "webarchive", subdirectory: "Fixtures"))
        let data = try Data(contentsOf: url)
        let webArchive = try PropertyListDecoder().decode(WebArchive.self, from: data)

        let mainResource = webArchive.mainResource
        XCTAssertEqual(mainResource.mimeType, "text/html")
        XCTAssertEqual(mainResource.url, try XCTUnwrap(URL(string: "https://en.wikipedia.org/wiki/Main_Page#/media/File:Adele_for_Vogue_in_2021.png")))
        XCTAssertEqual(mainResource.frameName, "")
        XCTAssertNotNil(mainResource.data)

        let subresources = try XCTUnwrap(webArchive.subresources)
        XCTAssertEqual(subresources.count, 1)

        let subresource = try XCTUnwrap(subresources.first)
        XCTAssertEqual(subresource.mimeType, "image/png")
        XCTAssertEqual(subresource.url, try XCTUnwrap(URL(string: "https://upload.wikimedia.org/wikipedia/commons/5/52/Adele_for_Vogue_in_2021.png")))
        XCTAssertNil(subresource.frameName)
        XCTAssertNotNil(subresource.data)
    }
}
