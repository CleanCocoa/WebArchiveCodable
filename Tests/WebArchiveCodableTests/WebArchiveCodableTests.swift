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
        XCTAssertEqual(mainResource.textEncodingName, "UTF-8")

        let subresources = try XCTUnwrap(webArchive.subresources)
        XCTAssertEqual(subresources.count, 1)

        let subresource = try XCTUnwrap(subresources.first)
        XCTAssertEqual(subresource.mimeType, "image/png")
        XCTAssertEqual(subresource.url, try XCTUnwrap(URL(string: "https://upload.wikimedia.org/wikipedia/commons/5/52/Adele_for_Vogue_in_2021.png")))
        XCTAssertNil(subresource.frameName)
        XCTAssertNil(subresource.textEncodingName)

        let imageData = try XCTUnwrap(subresource.data)
        XCTAssertNotNil(NSImage(data: imageData))
    }

    func test_ChristiantietzeDePostFixture() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "christiantietze.de-post", withExtension: "webarchive", subdirectory: "Fixtures"))
        let data = try Data(contentsOf: url)
        let webArchive = try PropertyListDecoder().decode(WebArchive.self, from: data)

        let mainResource = webArchive.mainResource
        XCTAssertEqual(mainResource.mimeType, "text/html")
        XCTAssertEqual(mainResource.url, try XCTUnwrap(URL(string: "https://christiantietze.de/posts/2022/11/nstableview-variable-row-heights-broken-macos-ventura-13-0/")))
        XCTAssertEqual(mainResource.frameName, "")
        XCTAssertEqual(mainResource.textEncodingName, "UTF-8")
        XCTAssertNotNil(String(data: try XCTUnwrap(mainResource.data), encoding: .utf8),
                        "Should be able to get UTF-8 string from the HTML.")

        let subresources = try XCTUnwrap(webArchive.subresources)
        XCTAssertEqual(subresources.count, 1)

        let cssFileSubresource = try XCTUnwrap(subresources.first)
        XCTAssertEqual(cssFileSubresource.mimeType, "text/css")
        XCTAssertEqual(cssFileSubresource.url, try XCTUnwrap(URL(string: "https://christiantietze.de/css/default.css")))
        XCTAssertNil(cssFileSubresource.frameName)
        XCTAssertNil(cssFileSubresource.textEncodingName)
        XCTAssertNotNil(String(data: try XCTUnwrap(cssFileSubresource.data), encoding: .utf8),
                        "Should be able to get UTF-8 string from the CSS.")
    }
}
