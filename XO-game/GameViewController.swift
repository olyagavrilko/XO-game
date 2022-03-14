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

//        if computerGame {
//            secondPlayerTurnLabel.text = "computer"
//        }
        
//        firstPlayerTurn()
        selectPosition()
    }
    
    private func selectPosition() {
        gameboardView.onSelectPosition = { [weak self] position in
            self?.strategy.onSelect(position: position)

//            if self.currentState is ComputerGameState {
//
//                var computerPosition: GameboardPosition
//
//                repeat {
//                    let column = Int.random(in: 0...2)
//                    let row = Int.random(in: 0...2)
//                    computerPosition = GameboardPosition(column: column, row: row)
//                } while !self.gameboardView.canPlaceMarkView(at: computerPosition)
//
//
//                self.currentState.addSign(at: computerPosition)
//            } else {
//                self.currentState.addSign(at: position)
//            }
//
//            if self.currentState.isMoveCompleted {
//                self.nextPlayerTurn()
//
//                if self.currentState is ComputerGameState {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                        self.gameboardView.onSelectPosition?(GameboardPosition(column: 0, row: 0))
//                    }
//                }
//            }
        }
    }
    
//    private func firstPlayerTurn() {
//        let firstPlayer: Player = .first
//        currentState = PlayerGameState(player: firstPlayer, gameBoardView: gameboardView, gameBoard: gameBoard, gameViewController: self, markViewPrototype: firstPlayer.markViewPrototype)
//    }
//
//    private func nextPlayerTurn() {
//        if let winner = referee.determineWinner() {
//            currentState = GameEndState(winnerPlayer: winner, gameViewController: self)
//            LoggerFunc.shared.log(action: .gameFinished(winner: winner))
//            return
//        }
//
//        if counter >= 9 {
//            currentState = GameEndState(winnerPlayer: nil, gameViewController: self)
//            LoggerFunc.shared.log(action: .gameFinished(winner: nil))
//            return
//        }
//
//        if computerGame {
//            if currentState is ComputerGameState {
//                let nextPlayer: Player = .first
//                currentState = PlayerGameState(player: nextPlayer, gameBoardView: gameboardView, gameBoard: gameBoard, gameViewController: self, markViewPrototype: nextPlayer.markViewPrototype)
//            } else if currentState is PlayerGameState {
//                let nextPlayer: Computer = Computer()
//                currentState = ComputerGameState(computer: nextPlayer, gameBoardView: gameboardView, gameBoard: gameBoard, gameViewController: self, markViewPrototype: nextPlayer.markViewPrototype)
//            }
//        } else {
//            if let playerState = currentState as? PlayerGameState {
//                let nextPlayer = playerState.player.next
//                currentState = PlayerGameState(player: nextPlayer, gameBoardView: gameboardView, gameBoard: gameBoard, gameViewController: self, markViewPrototype: nextPlayer.markViewPrototype)
//            }
//        }
//    }

    @IBAction func restartButtonTapped(_ sender: UIButton) {
        LoggerFunc.shared.log(action: .restartGame)
        
        gameboardView.clear()
        gameBoard.clear()

        strategy.begin()
    }
}
