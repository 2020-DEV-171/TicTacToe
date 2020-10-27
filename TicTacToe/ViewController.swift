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
    private let restartButton: UIButton = UIButton(type: .custom)
    private var buttons: Dictionary<Position, UIButton> = Dictionary()
    private let board: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        setupViews()
        connectViews()
        
        viewModel.start()
    }
    
    private func setupViews() {
        
        setupCurrentPlayerLabel()
        setupBoard()
        setupRestartButton()

        setupContainer()
    }

    private func setupCurrentPlayerLabel() {
        currentPlayerLabel.text = " "
    }
    
    private func setupRestartButton() {
        restartButton.setTitleColor(.black, for: .normal)
        restartButton.backgroundColor = .init(white: 0.9, alpha: 1.0)
        restartButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        restartButton.setTitle("Restart", for: .normal)
    }
    
    private func setupBoard() {
        
        let positions: [[Position]] = [
            [.topLeft, .topCenter, .topRight],
            [.middleLeft, .middleCenter, .middleRight],
            [.bottomLeft, .bottomCenter, .bottomRight]
        ]
        
        // create all the buttons and put them in the dictionary
        for position in positions.flatMap({$0}) {
            buttons[position] = createBoardButton(for: position)
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
    
    private func createBoardButton(for position: Position) -> UIButton {
        let button = UIButton(type: .custom)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1.0).isActive = true
        button.setTitleColor(.black, for: .normal)
        button.accessibilityLabel = "\(position)"
        return button
    }
    
    private func setupContainer() {
        let container = UIStackView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.spacing = 10.0
        container.addArrangedSubview(currentPlayerLabel)
        container.addArrangedSubview(board)
        container.addArrangedSubview(restartButton)
        view.addSubview(container)
        container.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10.0).isActive = true
        container.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10.0).isActive = true
        container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive = true
    }
    
    private func connectViews() {
        restartButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        for button in buttons.values {
            button.addTarget(self, action: #selector(boardButtonTapped(sender:)), for: .touchUpInside)
        }
    }
    
    @objc private func startButtonTapped() {
        viewModel.start()
    }
    
    @objc private func boardButtonTapped(sender: UIButton) {
        for (position, button) in buttons {
            if button == sender {
                viewModel.play(at: position)
            }
        }
    }
}

extension ViewController: ViewModelDelegate {
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.viewModel.alertDismissed()
        }))
        present(alertController, animated: true)
    }
    
    func setBoardButtonTitle(title: String, at position: Position) {
        if let button = buttons[position] {
            button.setTitle(title, for: .normal)
        }
    }
    
    func setCurrentPlayer(name: String) {
        currentPlayerLabel.text = name
    }
}
