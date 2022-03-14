//
//  PlayerGameState.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 08.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class PlayerGameState: GameState {
    var isMoveCompleted: Bool = false
    public let player: Player
    
    weak var gameBoardView: GameboardView?
    weak var gameBoard: Gameboard?
    weak var gameViewController: GameViewController?
    
    let markViewPrototype: MarkView
    
    init(player: Player, gameBoardView: GameboardView, gameBoard: Gameboard, gameViewController: GameViewController, markViewPrototype: MarkView) {
        self.player = player
        self.gameBoardView = gameBoardView
        self.gameBoard = gameBoard
        self.gameViewController = gameViewController
        
        self.markViewPrototype = markViewPrototype
    }
    
    func addSign(at position: GameboardPosition) {
        guard let gameBoardView = gameBoardView,
              gameBoardView.canPlaceMarkView(at: position)
        else {
            return
        }
        
        LoggerFunc.shared.log(action: .playerSetSign(player: player, position: position))
        gameBoard?.setPlayer(player, at: position)
        gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)
        isMoveCompleted = true
    }
    
    func begin() {
        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true

            gameViewController?.firstPlayerTurnLabel.text = "Игрок 1: Человек"
        case .second:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = false

            gameViewController?.secondPlayerTurnLabel.text = "Игрок 2: Человек"
        }
        
        gameViewController?.winnerLabel.isHidden = true
    }
}
