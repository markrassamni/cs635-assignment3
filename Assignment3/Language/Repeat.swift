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

    func interpret(turtle: Turtle, context: Context) -> Int? {
        guard let interpretedValue = value.evaluate(context: context) else { return 0 }
        return interpretedValue < 0 ? 0 : interpretedValue
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}
