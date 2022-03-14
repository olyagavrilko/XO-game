//
//  Strategy.swift
//  XO-game
//
//  Created by Olya Ganeva on 14.03.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol Strategy {
    var view: GameViewController! { get set }

    func begin()
    func onSelect(position: GameboardPosition)
}

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

final class ManAndComputerStrategy: Strategy {

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

        guard currentState is PlayerGameState else {
            return
        }

        addSign(position: position)
    }

    private func addSign(position: GameboardPosition) {

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

            nextPlayerTurn()
        }
    }

    private func nextPlayerTurn() {

        currentPlayer = currentPlayer.next

        if currentState is PlayerGameState {
            currentState = ComputerGameState(
                player: currentPlayer,
                gameBoardView: view.gameboardView,
                gameBoard: view.gameBoard,
                gameViewController: view,
                markViewPrototype: currentPlayer.markViewPrototype)

            var computerPosition: GameboardPosition

            repeat {
                let column = Int.random(in: 0...2)
                let row = Int.random(in: 0...2)
                computerPosition = GameboardPosition(column: column, row: row)
            } while !view.gameboardView.canPlaceMarkView(at: computerPosition)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.addSign(position: computerPosition)
            }
        } else {
            currentState = PlayerGameState(
                player: currentPlayer,
                gameBoardView: view.gameboardView,
                gameBoard: view.gameBoard,
                gameViewController: view,
                markViewPrototype: currentPlayer.markViewPrototype)
        }
    }
}


