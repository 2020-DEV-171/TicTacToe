//
//  ViewController.swift
//  TicTacToe
//
//  Created by Marco Mustapic on 23/10/2020.
//

import UIKit

class ViewController: UIViewController {

    private let viewModel = ViewModel()
    
    private let currentPlayerLabel: UILabel = UILabel()
    private let startButton: UIButton = UIButton(type: .custom)
    private var buttons: Dictionary<Position, UIButton> = Dictionary()
    private let board: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        createViews()
        connectViews()
    }
    
    private func createViews() {
        
        createCurrentPlayerLabel()
        createBoard()
        createStartButton()

        createContainer()
    }

    private func createCurrentPlayerLabel() {
        currentPlayerLabel.text = " "
    }
    
    private func createStartButton() {
        startButton.setTitleColor(.black, for: .normal)
        startButton.backgroundColor = .init(white: 0.9, alpha: 1.0)
        startButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        startButton.setTitle("Start", for: .normal)
    }
    
    private func createBoard() {
        
        let positions: [[Position]] = [
            [.topLeft, .topCenter, .topRight],
            [.middleLeft, .middleCenter, .middleRight],
            [.bottomLeft, .bottomCenter, .bottomRight]
        ]
        
        // create all the buttons and put them in the dictionary
        for position in positions.flatMap({$0}) {
            buttons[position] = createBoardButton()
        }
        
        // now create board
        let rows = positions.map { (positions) -> UIView in
            let views = positions.compactMap { (position) -> UIButton? in
                return buttons[position]
            }
            let buttonsStackView = UIStackView(arrangedSubviews: views)
            buttonsStackView.axis = .horizontal
            buttonsStackView.alignment = .fill
            return buttonsStackView
        }
        let rowsStackView = UIStackView(arrangedSubviews: rows)
        rowsStackView.axis = .vertical
        rowsStackView.alignment = .fill
        rowsStackView.translatesAutoresizingMaskIntoConstraints = false

        board.addSubview(rowsStackView)
        rowsStackView.leftAnchor.constraint(equalTo: board.leftAnchor).isActive = true
        rowsStackView.rightAnchor.constraint(equalTo: board.rightAnchor).isActive = true
        rowsStackView.topAnchor.constraint(equalTo: board.topAnchor).isActive = true
        rowsStackView.bottomAnchor.constraint(equalTo: board.bottomAnchor).isActive = true
    }
    
    private func createBoardButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1.0).isActive = true
        return button
    }
    
    private func createContainer() {
        let container = UIStackView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.spacing = 10.0
        container.addArrangedSubview(currentPlayerLabel)
        container.addArrangedSubview(board)
        container.addArrangedSubview(startButton)
        view.addSubview(container)
        container.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10.0).isActive = true
        container.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10.0).isActive = true
        container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive = true
    }
    
    private func connectViews() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc fileprivate func startButtonTapped() {
        viewModel.start()
    }
}

extension ViewController: ViewModelDelegate {
    func setCurrentPlayer(name: String) {
        currentPlayerLabel.text = name
    }
}
