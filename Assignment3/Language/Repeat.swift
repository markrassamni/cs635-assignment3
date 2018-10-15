//
//  Repeat.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Repeat: Statement {

    private(set) var value: Value
    let statements: [Statement]
    
    var description: String {
        return "Repeat \(statements) \(value) times."
    }
    
    init(statements: [Statement], value: Value) {
        self.statements = statements
        self.value = value
    }

    func interpret(turtle: Turtle, context: Context) {
        guard var count = value.evaluate(context: context) else { return }
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
