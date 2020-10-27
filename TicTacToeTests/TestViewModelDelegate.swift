//
//  TestViewModelDelegate.swift
//  TicTacToeTests
//
//  Created by Marco Mustapic on 27/10/2020.
//

import Foundation

class TestViewModelDelegate: TestDelegate<TestViewModelDelegateEvent>, ViewModelDelegate {
    
    func setCurrentPlayer(name: String) {
        eventArrived(event: .setCurentPlayer(name))
    }
}

enum TestViewModelDelegateEvent: Equatable {
    case setCurentPlayer(String)
}

extension TestViewModelDelegateEvent: CustomDebugStringConvertible {
    
    var debugDescription: String {
        switch self {
        case .setCurentPlayer(let name):
            return "setCurentPlayer(\(name))"
        }
    }

}
