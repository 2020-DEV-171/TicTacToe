//
//  TestViewModelDelegate.swift
//  TicTacToeTests
//
//  Created by Marco Mustapic on 27/10/2020.
//

import Foundation

class TestViewModelDelegate: TestDelegate<TestViewModelDelegateEvent>, ViewModelDelegate {
    func showAlert(message: String) {
        eventArrived(event: .showAlert(message))
    }
    
    func setBoardButtonTitle(title: String, at position: Position) {
        eventArrived(event: .setBoardButtonTitle(title, position))
    }
    
    func setCurrentPlayer(name: String) {
        eventArrived(event: .setCurentPlayer(name))
    }
}

enum TestViewModelDelegateEvent: Equatable {
    case setCurentPlayer(String)
    case setBoardButtonTitle(String, Position)
    case showAlert(String)
}

extension TestViewModelDelegateEvent: CustomDebugStringConvertible {
    
    var debugDescription: String {
        switch self {
        case .setCurentPlayer(let name):
            return "setCurentPlayer(\(name))"
        case .setBoardButtonTitle(let title, let position):
            return "setBoardButtonTitle(\(title),\(position))"
        case .showAlert(let message):
            return "showAlert(\(message))"
        }
    }

}
