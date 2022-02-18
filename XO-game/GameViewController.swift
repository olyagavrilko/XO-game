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
    
    private var gameBoard: Gameboard = Gameboard()
    private lazy var referee: Referee = Referee(gameboard: gameBoard)
    private var counter: Int = 0
    
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstPlayerTurn()
        selectPosition()
        
    }
    
    private func selectPosition() {
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            
            self.counter += 1
            self.currentState.addSign(at: position)
            
            if self.currentState.isMoveCompleted {
                self.nextPlayerTurn()
            }
        }
    }
    
    private func firstPlayerTurn() {
        let firstPlayer: Player = .first
        currentState = PlayerGameState(player: firstPlayer, gameBoardView: gameboardView, gameBoard: gameBoard, gameViewController: self, markViewPrototype: firstPlayer.markViewPrototype)
    }
    
    private func nextPlayerTurn() {
        if let winner = referee.determineWinner() {
            currentState = GameEndState(winnerPlayer: winner, gameViewController: self)
            LoggerFunc.shared.log(action: .gameFinished(winner: winner))
            return
        }
        
        if counter >= 9 {
            currentState = GameEndState(winnerPlayer: nil, gameViewController: self)
            LoggerFunc.shared.log(action: .gameFinished(winner: nil))
            return
        }
        
        if let playerState = currentState as? PlayerGameState {
            let nextPlayer = playerState.player.next
            currentState = PlayerGameState(player: nextPlayer, gameBoardView: gameboardView, gameBoard: gameBoard, gameViewController: self, markViewPrototype: nextPlayer.markViewPrototype)
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        LoggerFunc.shared.log(action: .restartGame)
        
        gameboardView.clear()
        gameBoard.clear()
        counter = 0

        firstPlayerTurn()
    }
}

