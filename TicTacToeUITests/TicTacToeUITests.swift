//
//  TicTacToeUITests.swift
//  TicTacToeUITests
//
//  Created by Marco Mustapic on 23/10/2020.
//

import XCTest

class TicTacToeUITests: XCTestCase {

    func testWin() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        app.buttons["topLeft"].tap()
        app.buttons["topCenter"].tap()
        app.buttons["middleLeft"].tap()
        app.buttons["middleCenter"].tap()
        app.buttons["bottomLeft"].tap()

        XCTAssertTrue(app.alerts.element.staticTexts["Player X Won!"].waitForExistence(timeout: 1.0), "should display a win alert")
    }

    func testCurrentPlayerUpdate() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.staticTexts["Current player: X"].waitForExistence(timeout: 0.1), "should display cross as current player")
        app.buttons["topLeft"].tap()
        XCTAssertTrue(app.staticTexts["Current player: O"].waitForExistence(timeout: 0.1), "should display circle as current player")
        app.buttons["topCenter"].tap()
        XCTAssertTrue(app.staticTexts["Current player: X"].waitForExistence(timeout: 0.1), "should display cross as current player")
    }

    func testPlay() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        app.buttons["topLeft"].tap()
        XCTAssertTrue(app.buttons["topLeft"].staticTexts["X"].waitForExistence(timeout: 0.1), "should display circle as current player")
    }
}
