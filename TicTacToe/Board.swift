//
//  Board.swift
//  TicTacToe
//
//  Created by Marco Mustapic on 25/10/2020.
//

import Foundation

enum BoardRow: Int, CaseIterable {
    case top
    case middle
    case bottom
}

enum BoardColumn: Int, CaseIterable {
    case left
    case center
    case right
}

enum BoardValue {
    case empty
    case cross
    case circle
}

class Board {
    private var cells: Array<Array<BoardValue>>
    
    init() {
        cells = Array<Array<BoardValue>>()
        for _ in BoardRow.allCases {
            var columns = Array<BoardValue>()
            for _ in BoardColumn.allCases {
                columns.append(.empty)
            }
            cells.append(columns)
        }
        reset()
    }
    
    func reset() {
        for row in BoardRow.allCases {
            for column in BoardColumn.allCases {
                cells[row.rawValue][column.rawValue] = .empty
            }
        }
    }
    
    func value(row: BoardRow, column: BoardColumn) -> BoardValue {
        return cells[row.rawValue][column.rawValue]  // there is always a value, we can force unwrap here
    }
    
    func setValue(value: BoardValue, row: BoardRow, column: BoardColumn) {
        cells[row.rawValue][column.rawValue] = value
    }
}
