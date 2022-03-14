//
//  FiveMarksState.swift
//  XO-game
//
//  Created by Olya Ganeva on 14.03.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class FiveMarksState: GameState {
    
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

    }

    func begin() {
        
    }
}
