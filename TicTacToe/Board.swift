//
//  Board.swift
//  TicTacToe
//
//  Created by Marco Mustapic on 25/10/2020.
//

import Foundation

enum BoardValue {
    case empty
    case cross
    case circle
}

class Board {
    private var cells: Dictionary<Position, BoardValue> = Dictionary()
    
    init() {
        reset()
    }
    
    func reset() {
        for position in Position.allCases {
            cells[position] = .empty
        }
    }
    
    func value(position: Position) -> BoardValue {
        return cells[position]!  // there is always a value, we can force unwrap here
    }
    
    func setValue(value: BoardValue, position: Position) {
        cells[position] = value
    }
    
    func emptyPositionCount() -> Int {
        return 0
    }
}
