import XCTest

class DefaultsBugUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app.terminate()
        super.tearDown()
    }
    
    func test1FromNotSeenToSeen() {
        app.buttons["onboarding not seen"].tap()
        XCTAssert(app.buttons["onboarding seen"].exists)
    }

    func test1FromSeenToNotSeen() {
        app.buttons["onboarding seen"].tap()
        XCTAssert(app.buttons["onboarding not seen"].exists)
    }

}
