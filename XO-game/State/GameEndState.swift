//
//  GameEndState.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 08.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class GameEndState: GameState {
    var isMoveCompleted: Bool = false
    
    public let winnerPlayer: Player?
    weak var gameViewController: GameViewController?
    
    init(winnerPlayer: Player?, gameViewController: GameViewController) {
        self.winnerPlayer = winnerPlayer
        self.gameViewController = gameViewController
    }
    
    func addSign(at position: GameboardPosition) {  }
    
    func begin() {
        gameViewController?.winnerLabel.isHidden = false
        
        if let winnerPlayer = winnerPlayer {
            gameViewController?.winnerLabel.text = setNamePlayerName(player: winnerPlayer) + " won"
        } else {
            gameViewController?.winnerLabel.text = "No winner/Draw"
        }
        
        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = true
    }
    
    private func setNamePlayerName(player: Player) -> String {
        switch player {
        case .first:
            return "First"
        case .second:
            return "Second"
        }
    }
}
