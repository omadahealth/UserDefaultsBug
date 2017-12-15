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
        sleep(3) // sleep to give iOS a chance to save defaults
        XCUIDevice.shared.press(.home) // on deactivate we syncronize defaults
        sleep(3) // sleep to give iOS one more chance to save defaults
        app.terminate() // all this additional sleeping doesn't seem to matter and the test still fails
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
