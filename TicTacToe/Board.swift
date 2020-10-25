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
    private lazy var cells: Array<Array<BoardValue>> = {
        var rows = Array<Array<BoardValue>>()
        for row in BoardRow.allCases {
            var columns = Array<BoardValue>()
            for column in BoardColumn.allCases {
                columns.append(.empty)
            }
            rows.append(columns)
        }
        return rows
    }()
    
    init() {
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
