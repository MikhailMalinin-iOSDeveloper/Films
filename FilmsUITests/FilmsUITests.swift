//
//  FilmsUITests.swift
//  FilmsUITests
//
//  Created by iOS_Coder on 13.05.2021.
//

@testable import Films
import XCTest

final class FilmsUITests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testUI() {
        let app = XCUIApplication()
        app.launch()

        app.tables.cells.firstMatch.tap()
        sleep(2)
        app.navigationBars.buttons.firstMatch.tap()
        sleep(2)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
