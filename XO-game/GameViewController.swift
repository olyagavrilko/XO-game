//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!

    var strategy: Strategy!
    
    var gameBoard: Gameboard = Gameboard()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        strategy.view = self
        strategy.begin()

        selectPosition()
    }
    
    private func selectPosition() {
        gameboardView.onSelectPosition = { [weak self] position in
            self?.strategy.onSelect(position: position)
        }
    }

    @IBAction func restartButtonTapped(_ sender: UIButton) {
        LoggerFunc.shared.log(action: .restartGame)
        
        gameboardView.clear()
        gameBoard.clear()

        strategy.begin()
    }
}
