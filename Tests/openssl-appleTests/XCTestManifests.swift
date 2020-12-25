import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(openssl_appleTests.allTests),
    ]
}
#endif
