//
//  ComputerGameState.swift
//  XO-game
//
//  Created by Olya Ganeva on 11.03.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class ComputerGameState: GameState {

    var isMoveCompleted: Bool = false
    public let computer: Computer

    weak var gameBoardView: GameboardView?
    weak var gameBoard: Gameboard?
    weak var gameViewController: GameViewController?

    let markViewPrototype: MarkView

    init(computer: Computer, gameBoardView: GameboardView, gameBoard: Gameboard, gameViewController: GameViewController, markViewPrototype: MarkView) {
        self.computer = computer
        self.gameBoardView = gameBoardView
        self.gameBoard = gameBoard
        self.gameViewController = gameViewController

        self.markViewPrototype = markViewPrototype
    }

    func begin() {
        gameViewController?.firstPlayerTurnLabel.isHidden = true
    }
    
    func addSign(at position: GameboardPosition) {
        guard let gameBoardView = gameBoardView,
              gameBoardView.canPlaceMarkView(at: position) else {
            return
        }

        LoggerFunc.shared.log(action: .computerSetSign(computer: computer, position: position))
        gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)
        isMoveCompleted = true
    }
}
