//
//  Repeat.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Repeat: Statement {
    
    private(set) var count: Int!
    private(set) var variableName: String?
    let statements: [Statement]
    
    var description: String {
        if let repeatcount = count {
            return "Repeat \(statements) \(repeatcount) times"
        }
        return "Repeat \(statements) \(String(describing: variableName)) times."
    }
    
    init(statements: [Statement], repeatCount count: Int){
        self.statements = statements
        self.count = count
    }
    
    init(statements: [Statement], variableName: String) {
        self.statements = statements
        self.variableName = variableName
    }

    func interpret(turtle: Turtle, context: Context) -> Int? {
        let repeatCount: Int
        if let value = count {
            repeatCount = value
        } else if let name = variableName, let value = context.getValue(for: name) {
            repeatCount = value
        } else {
            return nil
        }
        guard repeatCount > 0 else { return 0 }
        
        // TODO: Should this interpret all statements here? Just return a count and let others handle interpreting
        for _ in 0..<repeatCount{
            for statement in statements {
                let _ = statement.interpret(turtle: turtle, context: context)
            }
        }
        return repeatCount
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}
