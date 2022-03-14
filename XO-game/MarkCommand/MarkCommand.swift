//
//  MarkCommand.swift
//  XO-game
//
//  Created by Olya Ganeva on 15.03.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class MarkCommand {

    private let player: Player
    private let gameBoard: Gameboard
    private let gameBoardView: GameboardView
    private let position: GameboardPosition

    init(player: Player, gameBoard: Gameboard, gameBoardView: GameboardView, position: GameboardPosition) {
        self.player = player
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
        self.position = position
    }

    func execute() {
        LoggerFunc.shared.log(action: .playerSetSign(player: player, position: position))
        gameBoard.setPlayer(player, at: position)
        gameBoardView.removeMarkView(at: position)
        gameBoardView.placeMarkView(player.markViewPrototype.copy(), at: position)
    }
}
