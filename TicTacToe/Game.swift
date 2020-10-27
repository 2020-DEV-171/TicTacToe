//
//  Game.swift
//  TicTacToe
//
//  Created by Marco Mustapic on 25/10/2020.
//

import Foundation

enum Player {
    case circle
    case cross
}

enum GameFinishCondition {
    case won(Player)
    case tie
}

// clients will use this delegate to play
protocol GameDelegate: class {
    func game(_ game: Game, updatedValue value: BoardValue, at row: BoardRow, _ column: BoardColumn)
    func game(_ game: Game, finishedWithCondition condition: GameFinishCondition)
    func game(_ game: Game, turnChangedTo player: Player)
}

class Game {
    private let board: Board = Board()
    private var currentPlayer: Player = .circle
    private var finished  = true
    
    weak var delegate: GameDelegate?
    
    private let winningSequences: [[(BoardRow, BoardColumn)]] = [
        // vertical
        [(.top, .left), (.middle, .left), (.bottom, .left)],
        [(.top, .center), (.middle, .center), (.bottom, .center)],
        [(.top, .right), (.middle, .right), (.bottom, .right)],

        // horizontal
        [(.top, .left), (.top, .center), (.top, .right)],
        [(.middle, .left), (.middle, .center), (.middle, .right)],
        [(.bottom, .left), (.bottom, .center), (.bottom, .right)],

        // diagonal
        [(.top, .left), (.middle, .center), (.bottom, .right)],
        [(.bottom, .left), (.middle, .center), (.top, .right)]
    ]
    
    func start() {
        finished = false
        board.reset()
        for row in BoardRow.allCases {
            for column in BoardColumn.allCases {
                delegate?.game(self, updatedValue: board.value(row: row, column: column), at: row, column)
            }
        }
        setCurrentPlayer(.cross)
    }
    
    func play(row: BoardRow, column: BoardColumn) {
        if !finished {
            if board.value(row: row, column: column) == .empty {
                board.setValue(value: currentPlayer.boardValue(), row: row, column: column)
                delegate?.game(self, updatedValue: currentPlayer.boardValue(), at: row, column)
            }
            
            if let condition = isGameFinished() {
                finished = true
                delegate?.game(self, finishedWithCondition: condition)
            } else {
                setCurrentPlayer(currentPlayer.otherPlayer())
            }
        }
    }
    
    private func isGameFinished() -> GameFinishCondition? {

        // first test if somebody had a winning sequence
        for sequence in winningSequences {
            if let uniqueValue = uniqueValueInWinningSequence(sequence) {
                if case .cross = uniqueValue {
                    return .won(.cross)
                }
                else if case .circle = uniqueValue {
                    return .won(.circle)
                }
            }
        }
        
        // otherwise check if are still empty cells to play
        if emptyPositionCount() == 0 {
            return .tie
        } else {
            return nil
        }
    }

    // return the unique value, if any, for a winning sequence. If there are multiple values, return nil
    private func uniqueValueInWinningSequence(_ sequence: [(BoardRow, BoardColumn)]) -> BoardValue? {
        let valuesInSequence = sequence.map { (row, column) -> BoardValue in
            return board.value(row: row, column: column)
        }
        let uniqueValues = Set(valuesInSequence)
        if uniqueValues.count == 1 {
            return uniqueValues.first
        } else {
            return nil
        }
    }
    
    private func emptyPositionCount() -> Int {
        var count: Int = 0
        for row in BoardRow.allCases {
            for column in BoardColumn.allCases {
                if board.value(row: row, column: column) == .empty {
                    count += 1
                }
            }
        }
        return count
    }
    
    private func setCurrentPlayer(_ newPlayer: Player) {
        currentPlayer = newPlayer
        delegate?.game(self, turnChangedTo: currentPlayer)
    }
}

extension Player {
    func boardValue() -> BoardValue {
        switch self {
        case .circle:
            return .circle
        case .cross:
            return .cross
        }
    }
    
    func otherPlayer() -> Player {
        switch self {
        case .circle:
            return .cross
        case .cross:
            return .circle
        }
    }
}
