//
//  TestGameDelegate.swift
//  TicTacToeTests
//
//  Created by Marco Mustapic on 26/10/2020.
//

import XCTest
@testable import TicTacToe

class TestGameDelegate: GameDelegate {
    
    fileprivate let expectation: XCTestExpectation
    fileprivate let expectedEventCount: Int
    var events: [TestGameDelegateEvent] = []

    init(expectation: XCTestExpectation, expectedEventCount: Int) {
        self.expectation = expectation
        self.expectedEventCount = expectedEventCount
    }

    func game(_ game: Game, updatedValue value: BoardValue, at row: BoardRow, _ column: BoardColumn) {
        eventArrived(event: .upated(value, row, column))
    }

    func game(_ game: Game, finishedWithCondition condition: GameFinishCondition) {
        eventArrived(event: .finished(condition))
    }

    func game(_ game: Game, turnChangedTo player: Player) {
        eventArrived(event: .turnChanged(player))
    }

    fileprivate func eventArrived(event: TestGameDelegateEvent) {
        events.append(event)
        if events.count == expectedEventCount {
            expectation.fulfill()
        }
    }
}


enum TestGameDelegateEvent: Equatable {
    case upated(BoardValue, BoardRow, BoardColumn)
    case finished(GameFinishCondition)
    case turnChanged(Player)
}

extension TestGameDelegateEvent: CustomDebugStringConvertible {
    
    var debugDescription: String {
        switch self {
        case .upated(let value, let row, let column):
            return "updated(\(value), \(row), \(column))"
        case .finished(let condition):
            return "finished(\(condition))"
        case .turnChanged(let player):
            return "turnChanged(\(player))"
        }
    }

}

extension GameFinishCondition: Equatable {
    public static func == (lhs: GameFinishCondition, rhs: GameFinishCondition) -> Bool {
        switch (lhs, rhs) {
        case (.won(let lplayer), .won(let rplayer)):
            return lplayer == rplayer
        case (.tie, .tie):
            return true
        default:
            return false
        }
    }
}
