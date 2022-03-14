//
//  MenuViewController.swift
//  XO-game
//
//  Created by Olya Ganeva on 18.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

final class MenuViewController: UIViewController {

    private let computerGameButton = UIButton()
    private let twoPlayerGameButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        computerGameButton.setTitle("Игра против компьютера", for: .normal)
        computerGameButton.addTarget(self, action: #selector(computerGameButtonDidTap), for: .touchUpInside)
        view.addSubview(computerGameButton)
        computerGameButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            computerGameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            computerGameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            computerGameButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
        ])

        twoPlayerGameButton.setTitle("Игра с двумя игроками", for: .normal)
        twoPlayerGameButton.addTarget(self, action: #selector(twoPlayerGameButtonDidTap), for: .touchUpInside)
        view.addSubview(twoPlayerGameButton)
        twoPlayerGameButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            twoPlayerGameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            twoPlayerGameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            twoPlayerGameButton.topAnchor.constraint(equalTo: computerGameButton.bottomAnchor, constant: 32)
        ])
    }

    @objc private func computerGameButtonDidTap() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let gameViewController = storyBoard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        gameViewController.computerGame = true

        show(gameViewController, sender: nil)
    }

    @objc private func twoPlayerGameButtonDidTap() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let gameViewController = storyBoard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController

        show(gameViewController, sender: nil)
    }
}
