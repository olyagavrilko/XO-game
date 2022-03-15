//
//  FiveMarksStrategy.swift
//  XO-game
//
//  Created by Olya Ganeva on 15.03.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class FiveMarksStrategy: Strategy {

    weak var view: GameViewController!

    lazy var referee = Referee(gameboard: view.gameBoard)

    private var firstPlayerCommands: [MarkCommand] = []
    private var secondPlayerCommands: [MarkCommand] = []

    private var currentPlayer: Player = .first

    var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }

    func begin() {

        currentPlayer = .first
        firstPlayerCommands.removeAll()
        secondPlayerCommands.removeAll()

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

            let markCommand = MarkCommand(
                player: currentPlayer,
                gameBoard: view.gameBoard,
                gameBoardView: view.gameboardView,
                position: position)

            switch currentPlayer {
            case .first:
                firstPlayerCommands.append(markCommand)
            case .second:
                secondPlayerCommands.append(markCommand)
            }

            if firstPlayerCommands.count == 5 && secondPlayerCommands.count == 0 {
                view.gameboardView.clear()
                view.gameBoard.clear()
                currentPlayer = .second
                currentState = PlayerGameState(
                    player: currentPlayer,
                    gameBoardView: view.gameboardView,
                    gameBoard: view.gameBoard,
                    gameViewController: view,
                    markViewPrototype: currentPlayer.markViewPrototype)
            } else if secondPlayerCommands.count == 5 {
                view.gameboardView.clear()
                view.gameBoard.clear()
                currentState = FiveMarksGameExecutionState(
                    firstPlayerCommands: firstPlayerCommands,
                    secondPlayerCommands: secondPlayerCommands,
                    strategy: self)
            }
        }
    }
}
