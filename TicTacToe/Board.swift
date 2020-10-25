//
//  Board.swift
//  TicTacToe
//
//  Created by Marco Mustapic on 25/10/2020.
//

import Foundation

enum BoardRow: CaseIterable {
    case top
    case middle
    case bottom
}

enum BoardColumn: CaseIterable {
    case left
    case center
    case right
}

enum BoardValue {
    case empty
    case cross
    case circle
}

fileprivate struct BoardPosition: Hashable {
    let row: BoardRow
    let column: BoardColumn
}

class Board {
    private var cells: Dictionary<BoardPosition, BoardValue> = Dictionary()
    
    init() {
        reset()
    }
    
    func reset() {
        cells.removeAll()
        for row in BoardRow.allCases {
            for column in BoardColumn.allCases {
                cells[BoardPosition(row: row, column: column)] = .empty
            }
        }
    }
    
    func value(row: BoardRow, column: BoardColumn) -> BoardValue {
        return cells[BoardPosition(row: row, column: column)]!  // there is always a value, we can force unwrap here
    }
    
    func setValue(value: BoardValue, row: BoardRow, column: BoardColumn) {
        cells[BoardPosition(row: row, column: column)] = value
    }
}
