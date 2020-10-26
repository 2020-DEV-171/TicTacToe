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
    private(set) var currentPlayer: Player = .circle
    
    var delegate: GameDelegate?
    
    init() {
    }
    
    func start() {
        board.reset()
        for row in BoardRow.allCases {
            for column in BoardColumn.allCases {
                delegate?.game(self, updatedValue: board.value(row: row, column: column), at: row, column)
            }
        }
        setCurrentPlayer(.cross)
    }
    
    func play(row: BoardRow, column: BoardColumn) {
        if board.value(row: row, column: column) == .empty {
            board.setValue(value: currentPlayer.boardValue(), row: row, column: column)
            delegate?.game(self, updatedValue: currentPlayer.boardValue(), at: row, column)
        }
        // check win conditions
        setCurrentPlayer(currentPlayer.otherPlayer())
    }
    
    func isGameFinished() -> Bool {
        return false
    }
    
    fileprivate func setCurrentPlayer(_ newPlayer: Player) {
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
