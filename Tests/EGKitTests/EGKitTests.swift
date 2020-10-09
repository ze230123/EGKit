import XCTest
@testable import EGKit
import EGRefresh

final class EGKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let ref = Refresh {
            print("load")
        }
        print(ref.image)
        XCTAssertNotNil(ref.image)
    }

    
    static var allTests = [
        ("testExample", testExample),
    ]
}
