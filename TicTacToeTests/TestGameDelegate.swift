//
//  TestGameDelegate.swift
//  TicTacToeTests
//
//  Created by Marco Mustapic on 26/10/2020.
//

import XCTest
@testable import TicTacToe

class TestGameDelegate: TestDelegate<TestGameDelegateEvent>, GameDelegate {
    
    func game(_ game: Game, updatedValue value: BoardValue, at position: Position) {
        eventArrived(event: .upated(value, position))
    }

    func game(_ game: Game, finishedWithCondition condition: GameFinishCondition) {
        eventArrived(event: .finished(condition))
    }

    func game(_ game: Game, turnChangedTo player: Player) {
        eventArrived(event: .turnChanged(player))
    }
}


enum TestGameDelegateEvent: Equatable {
    case upated(BoardValue, Position)
    case finished(GameFinishCondition)
    case turnChanged(Player)
}

extension TestGameDelegateEvent: CustomDebugStringConvertible {
    
    var debugDescription: String {
        switch self {
        case .upated(let value, let position):
            return "updated(\(value), \(position))"
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
