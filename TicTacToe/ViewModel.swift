//
//  ViewModel.swift
//  TicTacToe
//
//  Created by Marco Mustapic on 27/10/2020.
//

import Foundation

protocol ViewModelDelegate: class {
    func setCurrentPlayer(name: String)
}

class ViewModel {
    weak var delegate: ViewModelDelegate?
    
    lazy private var game: Game = {
        let game = Game()
        game.delegate = self
        return game
    }()
    
    func start() {
        game.start()
    }
}

extension ViewModel: GameDelegate {
    func game(_ game: Game, updatedValue value: BoardValue, at position: Position) {
        
    }
    
    func game(_ game: Game, finishedWithCondition condition: GameFinishCondition) {
    }
    
    func game(_ game: Game, turnChangedTo player: Player) {
        delegate?.setCurrentPlayer(name: "Current player: \(player.name)")
    }
}

extension Player {
    var name: String {
        switch self {
        case .cross:
            return "X"
        case .circle:
            return "O"
        }
    }
}
