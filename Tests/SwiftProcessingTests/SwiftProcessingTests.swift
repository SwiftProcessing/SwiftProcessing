import XCTest
@testable import SwiftProcessing

final class SwiftProcessingTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftProcessing().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
