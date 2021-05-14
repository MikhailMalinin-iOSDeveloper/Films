//
//  FilmsUITests.swift
//  FilmsUITests
//
//  Created by iOS_Coder on 13.05.2021.
//

@testable import Films
import XCTest

final class FilmsUITests: XCTestCase {
    func testUI() {
        let app = XCUIApplication()
        app.launch()

        app.tables.cells.firstMatch.tap()
        sleep(2)
        app.scrollViews.firstMatch.swipeLeft()
        sleep(2)
        app.scrollViews.firstMatch.swipeLeft()
        sleep(2)
        app.tables.firstMatch.swipeUp()
        sleep(2)
        app.navigationBars.buttons.firstMatch.tap()
        sleep(2)
        app.tables.firstMatch.swipeUp()
        sleep(2)
    }
}
