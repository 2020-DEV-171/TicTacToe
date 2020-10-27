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

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        layoutViews()
        connectViews()
    }
    
    private func layoutViews() {
        currentPlayerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentPlayerLabel)
        currentPlayerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        currentPlayerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitleColor(.black, for: .normal)
        startButton.backgroundColor = .init(white: 0.9, alpha: 1.0)
        view.addSubview(startButton)
        startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0).isActive = true
        startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10.0).isActive = true
        startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        startButton.setTitle("Start", for: .normal)
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
