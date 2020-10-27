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
    func game(_ game: Game, updatedValue value: BoardValue, at position: Position)
    func game(_ game: Game, finishedWithCondition condition: GameFinishCondition)
    func game(_ game: Game, turnChangedTo player: Player)
}

class Game {
    private let board: Board = Board()
    private var currentPlayer: Player = .circle
    private var finished  = true
    
    weak var delegate: GameDelegate?
    
    private let winningSequences: [[Position]] = [
        // vertical
        [(.topLeft), (.middleLeft), (.bottomLeft)],
        [(.topCenter), (.middleCenter), (.bottomCenter)],
        [(.topRight), (.middleRight), (.bottomRight)],

        // horizontal
        [(.topLeft), (.topCenter), (.topRight)],
        [(.middleLeft), (.middleCenter), (.middleRight)],
        [(.bottomLeft), (.bottomCenter), (.bottomRight)],

        // diagonal
        [(.topLeft), (.middleCenter), (.bottomRight)],
        [(.bottomLeft), (.middleCenter), (.topRight)]
    ]
    
    func start() {
        finished = false
        board.reset()
        for position in Position.allCases {
            delegate?.game(self, updatedValue: board.value(position: position), at: position)
        }
        setCurrentPlayer(.cross)
    }
    
    func play(position: Position) {
        if !finished {
            if board.value(position: position) == .empty {
                board.setValue(value: currentPlayer.boardValue(), position: position)
                delegate?.game(self, updatedValue: currentPlayer.boardValue(), at: position)
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
    private func uniqueValueInWinningSequence(_ sequence: [Position]) -> BoardValue? {
        let valuesInSequence = sequence.map { (position) -> BoardValue in
            return board.value(position: position)
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
        for position in Position.allCases {
            if board.value(position: position) == .empty {
                count += 1
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
