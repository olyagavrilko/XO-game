//
//  LoggerInvoker.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 08.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class LoggerInvoker {
    public static let shared = LoggerInvoker()
    
    private let receiver = LoggerReceiver()
    private var commands: [LoggerCommand] = []
    
    private let bufferSize = 6
    
    private init() {
        
    }
    
    func addLogCommand(command: LoggerCommand) {
        commands.append(command)
        execute()
    }
    
    private func execute() {
        guard commands.count >= bufferSize else {
            return
        }
        
        commands.forEach { receiver.sendMessage(message: $0.logMessage) }
        commands = []
    }
}
