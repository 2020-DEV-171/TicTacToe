//
//  GameTests.swift
//  TicTacToeTests
//
//  Created by Marco Mustapic on 26/10/2020.
//

import XCTest
@testable import TicTacToe

class GameTests: XCTestCase {

    func testStart() {
        let game = Game()
        let expectedEvents: [TestGameDelegateEvent] = [
            .upated(.empty, .top, .left), .upated(.empty, .top, .center), .upated(.empty, .top, .right),
            .upated(.empty, .middle, .left), .upated(.empty, .middle, .center), .upated(.empty, .middle, .right),
            .upated(.empty, .bottom, .left), .upated(.empty, .bottom, .center), .upated(.empty, .bottom, .right),
            .turnChanged(.cross)
        ]
        let delegate = TestGameDelegate(expectation: expectation(description: "board is initialised and first turn is set to cross"), expectedEventCount: expectedEvents.count)
        game.delegate = delegate
        game.start()
        waitForExpectations(timeout: 0.05) { (error) in
            if let _ = error {
                XCTFail("Delegate not called")
            }
            XCTAssertEqual(expectedEvents, delegate.events)
        }
    }
    
    func testPlay() {
        let game = Game()
        let expectedEvents: [TestGameDelegateEvent] = [
            .upated(.cross, .top, .left),
            .turnChanged(.circle),
            .upated(.circle, .top, .center),
            .turnChanged(.cross)
        ]
        let delegate = TestGameDelegate(expectation: expectation(description: "board is updated and turn changes when playing"), expectedEventCount: expectedEvents.count)
        game.start()
        game.delegate = delegate
        game.play(row: .top, column: .left)
        game.play(row: .top, column: .center)
        waitForExpectations(timeout: 0.05) { (error) in
            if let _ = error {
                XCTFail("Delegate not called")
            }
            XCTAssertEqual(expectedEvents, delegate.events)
        }
    }
    
    func testCrossWon() {
        let game = Game()
        let expectedEvents: [TestGameDelegateEvent] = [
            .upated(.cross, .top, .left),
            .turnChanged(.circle),
            .upated(.circle, .top, .center),
            .turnChanged(.cross),
            .upated(.cross, .middle, .left),
            .turnChanged(.circle),
            .upated(.circle, .middle, .center),
            .turnChanged(.cross),
            .upated(.cross, .bottom, .left),
            .finished(.won(.cross))
        ]
        let delegate = TestGameDelegate(expectation: expectation(description: "win condition is reached when playing a winning game"), expectedEventCount: expectedEvents.count)
        game.start()
        game.delegate = delegate
        game.play(row: .top, column: .left)
        game.play(row: .top, column: .center)
        game.play(row: .middle, column: .left)
        game.play(row: .middle, column: .center)
        game.play(row: .bottom, column: .left)
        waitForExpectations(timeout: 0.05) { (error) in
            if let _ = error {
                XCTFail("Delegate not called")
            }
            XCTAssertEqual(expectedEvents, delegate.events)
        }
    }

    func testTie() {
        let game = Game()
        let expectedEvents: [TestGameDelegateEvent] = [
            .upated(.cross, .top, .left),
            .turnChanged(.circle),
            .upated(.circle, .top, .right),
            .turnChanged(.cross),
            .upated(.cross, .middle, .center),
            .turnChanged(.circle),
            .upated(.circle, .bottom, .right),
            .turnChanged(.cross),
            .upated(.cross, .middle, .right),
            .turnChanged(.circle),
            .upated(.circle, .middle, .left),
            .turnChanged(.cross),
            .upated(.cross, .bottom, .center),
            .turnChanged(.circle),
            .upated(.circle, .top, .center),
            .turnChanged(.cross),
            .upated(.cross, .bottom, .left),
            .finished(.tie)
        ]
        let delegate = TestGameDelegate(expectation: expectation(description: "tie condition is reached when exhausting all possible moves without a win"), expectedEventCount: expectedEvents.count)
        game.start()
        game.delegate = delegate
        game.play(row: .top, column: .left)
        game.play(row: .top, column: .right)
        game.play(row: .middle, column: .center)
        game.play(row: .bottom, column: .right)
        game.play(row: .middle, column: .right)
        game.play(row: .middle, column: .left)
        game.play(row: .bottom, column: .center)
        game.play(row: .top, column: .center)
        game.play(row: .bottom, column: .left)
        waitForExpectations(timeout: 0.05) { (error) in
            if let _ = error {
                XCTFail("Delegate not called")
            }
            XCTAssertEqual(expectedEvents, delegate.events)
        }
    }
    
    func testNoEventsAfterWon() {
        let game = Game()
        let expectedEvents: [TestGameDelegateEvent] = [
            // cross win game
            .upated(.cross, .top, .left),
            .turnChanged(.circle),
            .upated(.circle, .top, .center),
            .turnChanged(.cross),
            .upated(.cross, .middle, .left),
            .turnChanged(.circle),
            .upated(.circle, .middle, .center),
            .turnChanged(.cross),
            .upated(.cross, .bottom, .left),
            .finished(.won(.cross)),

            // board initialization and first turn
            .upated(.empty, .top, .left), .upated(.empty, .top, .center), .upated(.empty, .top, .right),
            .upated(.empty, .middle, .left), .upated(.empty, .middle, .center), .upated(.empty, .middle, .right),
            .upated(.empty, .bottom, .left), .upated(.empty, .bottom, .center), .upated(.empty, .bottom, .right),
            .turnChanged(.cross)
        ]
        let delegate = TestGameDelegate(expectation: expectation(description: "after finishing a game, call delegate only after restarting a game"), expectedEventCount: expectedEvents.count)
        game.start()
        game.delegate = delegate
        
        // play cross win game
        game.play(row: .top, column: .left)
        game.play(row: .top, column: .center)
        game.play(row: .middle, column: .left)
        game.play(row: .middle, column: .center)
        game.play(row: .bottom, column: .left)
        // keey playing even after finishing
        game.play(row: .bottom, column: .center)
        game.play(row: .top, column: .right)
        game.play(row: .top, column: .center)
        // restart game
        game.start()
        waitForExpectations(timeout: 0.05) { (error) in
            if let _ = error {
                XCTFail("Delegate not called")
            }
        }
    }

}
