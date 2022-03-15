//
//  Strategy.swift
//  XO-game
//
//  Created by Olya Ganeva on 14.03.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol Strategy {
    var view: GameViewController! { get set }

    func begin()
    func onSelect(position: GameboardPosition)
}
