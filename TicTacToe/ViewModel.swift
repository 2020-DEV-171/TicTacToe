//
//  ViewModel.swift
//  TicTacToe
//
//  Created by Marco Mustapic on 27/10/2020.
//

import Foundation

protocol ViewModelDelegate: class {
    func setCurrentPlayer(name: String)
    func setBoardButtonTitle(title: String, at position: Position)
    func showAlert(message: String)
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
    
    func play(at position: Position) {
        game.play(at: position)
    }
    
    func alertDismissed() {
        game.start()
    }
}

extension ViewModel: GameDelegate {
    func game(_ game: Game, updatedValue value: BoardValue, at position: Position) {
        delegate?.setBoardButtonTitle(title: value.title, at: position)
    }
    
    func game(_ game: Game, finishedWithCondition condition: GameFinishCondition) {
        switch condition {
        case .won(let player):
            delegate?.showAlert(message: "Player \(player.name) Won!")
        case .tie:
            delegate?.showAlert(message: "Tie!")
        }
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

extension BoardValue {
    var title: String {
        switch self {
        case .empty:
            return ""
        case .cross:
            return "X"
        case .circle:
            return "O"
        }
    }
}
