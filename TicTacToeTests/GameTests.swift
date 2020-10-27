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
            .upated(.empty, .topLeft), .upated(.empty, .topCenter), .upated(.empty, .topRight),
            .upated(.empty, .middleLeft), .upated(.empty, .middleCenter), .upated(.empty, .middleRight),
            .upated(.empty, .bottomLeft), .upated(.empty, .bottomCenter), .upated(.empty, .bottomRight),
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
            .upated(.cross, .topLeft),
            .turnChanged(.circle),
            .upated(.circle, .topCenter),
            .turnChanged(.cross)
        ]
        let delegate = TestGameDelegate(expectation: expectation(description: "board is updated and turn changes when playing"), expectedEventCount: expectedEvents.count)
        game.start()
        game.delegate = delegate
        game.play(position: .topLeft)
        game.play(position: .topCenter)
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
            .upated(.cross, .topLeft),
            .turnChanged(.circle),
            .upated(.circle, .topCenter),
            .turnChanged(.cross),
            .upated(.cross, .middleLeft),
            .turnChanged(.circle),
            .upated(.circle, .middleCenter),
            .turnChanged(.cross),
            .upated(.cross, .bottomLeft),
            .finished(.won(.cross))
        ]
        let delegate = TestGameDelegate(expectation: expectation(description: "win condition is reached when playing a winning game"), expectedEventCount: expectedEvents.count)
        game.start()
        game.delegate = delegate
        game.play(position: .topLeft)
        game.play(position: .topCenter)
        game.play(position: .middleLeft)
        game.play(position: .middleCenter)
        game.play(position: .bottomLeft)
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
            .upated(.cross, .topLeft),
            .turnChanged(.circle),
            .upated(.circle, .topRight),
            .turnChanged(.cross),
            .upated(.cross, .middleCenter),
            .turnChanged(.circle),
            .upated(.circle, .bottomRight),
            .turnChanged(.cross),
            .upated(.cross, .middleRight),
            .turnChanged(.circle),
            .upated(.circle, .middleLeft),
            .turnChanged(.cross),
            .upated(.cross, .bottomCenter),
            .turnChanged(.circle),
            .upated(.circle, .topCenter),
            .turnChanged(.cross),
            .upated(.cross, .bottomLeft),
            .finished(.tie)
        ]
        let delegate = TestGameDelegate(expectation: expectation(description: "tie condition is reached when exhausting all possible moves without a win"), expectedEventCount: expectedEvents.count)
        game.start()
        game.delegate = delegate
        game.play(position: .topLeft)
        game.play(position: .topRight)
        game.play(position: .middleCenter)
        game.play(position: .bottomRight)
        game.play(position: .middleRight)
        game.play(position: .middleLeft)
        game.play(position: .bottomCenter)
        game.play(position: .topCenter)
        game.play(position: .bottomLeft)
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
            .upated(.cross, .topLeft),
            .turnChanged(.circle),
            .upated(.circle, .topCenter),
            .turnChanged(.cross),
            .upated(.cross, .middleLeft),
            .turnChanged(.circle),
            .upated(.circle, .middleCenter),
            .turnChanged(.cross),
            .upated(.cross, .bottomLeft),
            .finished(.won(.cross)),

            // board initialization and first turn
            .upated(.empty, .topLeft), .upated(.empty, .topCenter), .upated(.empty, .topRight),
            .upated(.empty, .middleLeft), .upated(.empty, .middleCenter), .upated(.empty, .middleRight),
            .upated(.empty, .bottomLeft), .upated(.empty, .bottomCenter), .upated(.empty, .bottomRight),
            .turnChanged(.cross)
        ]
        let delegate = TestGameDelegate(expectation: expectation(description: "after finishing a game, call delegate only after restarting a game"), expectedEventCount: expectedEvents.count)
        game.start()
        game.delegate = delegate
        
        // play cross win game
        game.play(position: .topLeft)
        game.play(position: .topCenter)
        game.play(position: .middleLeft)
        game.play(position: .middleCenter)
        game.play(position: .bottomLeft)
        // keey playing even after finishing
        game.play(position: .bottomCenter)
        game.play(position: .topRight)
        game.play(position: .topCenter)
        // restart game
        game.start()
        waitForExpectations(timeout: 0.05) { (error) in
            if let _ = error {
                XCTFail("Delegate not called")
            }
        }
    }

}
