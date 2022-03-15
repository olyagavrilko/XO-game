//
//  FiveMarksGameExecutionState.swift
//  XO-game
//
//  Created by Olya Ganeva on 15.03.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class FiveMarksGameExecutionState: GameState {

    var isMoveCompleted: Bool = false

    private let commands: [MarkCommand]
    weak var strategy: FiveMarksStrategy!

    init(firstPlayerCommands: [MarkCommand], secondPlayerCommands: [MarkCommand], strategy: FiveMarksStrategy) {

        var commands: [MarkCommand] = []
        for i in 0..<firstPlayerCommands.count {
            commands.append(firstPlayerCommands[i])
            commands.append(secondPlayerCommands[i])
        }
        self.commands = commands
        self.strategy = strategy
    }

    func addSign(at position: GameboardPosition) { }

    func begin() {
        strategy.view.firstPlayerTurnLabel.isHidden = true
        strategy.view.secondPlayerTurnLabel.isHidden = true
        strategy.view.winnerLabel.isHidden = false
        strategy.view.winnerLabel.text = "Игра играется"

        var index = 0

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if index < self.commands.count {
                self.commands[index].execute()

                if let winner = self.strategy.referee.determineWinner() {
                    self.strategy.currentState = GameEndState(
                        winnerPlayer: winner,
                        gameViewController: self.strategy.view)
                    LoggerFunc.shared.log(action: .gameFinished(winner: winner))
                    timer.invalidate()
                    return
                }
            } else {
                self.strategy.currentState = GameEndState(
                    winnerPlayer: nil,
                    gameViewController: self.strategy.view)
                timer.invalidate()
            }
            index += 1
        }
    }
}
