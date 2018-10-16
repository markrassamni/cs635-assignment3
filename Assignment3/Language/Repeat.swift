//
//  Repeat.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Repeat: Statement {

    let repeatCount: Value
    let statements: [Statement]
    
    var description: String {
        return "Repeat \(statements) \(repeatCount) times."
    }
    
    init(statements: [Statement], value: Value) {
        self.statements = statements
        self.repeatCount = value
    }

    func interpret(turtle: Turtle, context: Context) {
        guard var count = repeatCount.evaluate(context: context) else { return }
        if count < 0 { count = 0 }
        for _ in 0..<count {
            for statement in statements {
                statement.interpret(turtle: turtle, context: context)
            }
        }
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}
