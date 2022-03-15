//
//  ManAndManStrategy.swift
//  XO-game
//
//  Created by Olya Ganeva on 15.03.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class ManAndManStrategy: Strategy {

    weak var view: GameViewController!

    private lazy var referee = Referee(gameboard: view.gameBoard)

    private var counter: Int = 0
    private var currentPlayer: Player = .first

    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }

    func begin() {

        counter = 0
        currentPlayer = .first

        currentState = PlayerGameState(
            player: currentPlayer,
            gameBoardView: view.gameboardView,
            gameBoard: view.gameBoard,
            gameViewController: view,
            markViewPrototype: currentPlayer.markViewPrototype)
    }

    func onSelect(position: GameboardPosition) {
        currentState.addSign(at: position)

        if currentState.isMoveCompleted {

            counter += 1

            if let winner = referee.determineWinner() {
                currentState = GameEndState(winnerPlayer: winner, gameViewController: view)
                LoggerFunc.shared.log(action: .gameFinished(winner: winner))
                return
            }

            if counter >= 9 {
                currentState = GameEndState(winnerPlayer: nil, gameViewController: view)
                LoggerFunc.shared.log(action: .gameFinished(winner: nil))
                return
            }

            currentPlayer = currentPlayer.next

            currentState = PlayerGameState(
                player: currentPlayer,
                gameBoardView: view.gameboardView,
                gameBoard: view.gameBoard,
                gameViewController: view,
                markViewPrototype: currentPlayer.markViewPrototype)
        }
    }
}
