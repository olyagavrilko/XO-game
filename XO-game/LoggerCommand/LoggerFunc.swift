//
//  LoggerFunc.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 08.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class LoggerFunc {
    public static var shared = LoggerFunc()
    
    private init() {
        
    }
    
    public func log(action: LogAction) {
        let command = LoggerCommand(action: action)
        LoggerInvoker.shared.addLogCommand(command: command)
    }
}

