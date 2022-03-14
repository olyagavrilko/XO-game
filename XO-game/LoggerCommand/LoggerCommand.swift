//
//  LoggerCommand.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 08.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class LoggerCommand {
    let action: LogAction
    
    init(action: LogAction) {
        self.action = action
    }
    
    var logMessage: String {
        switch action {
        case .playerSetSign(let player, let position):
            return "\(player) \"Человек\" placed sign at postion \(position)"
        case .computerSetSign(let player, let position):
            return "\(player) \"Компьютер\" placed sign at postion \(position)"
        case .gameFinished(let winner):
            if let winner = winner {
                return "\(winner) won the game"
            } else {
                return "Is Draw"
            }
        case .restartGame:
            return "Game was restarted"
        }
    }
}
