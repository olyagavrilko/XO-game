//
//  GameState.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 08.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol GameState {
    var isMoveCompleted: Bool { get }
    func addSign(at position: GameboardPosition)
    func begin()
}
