//
//  Turn.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Turn: Statement {
    
    private(set) var degrees: Int!
    private(set) var variableName: String?
    
    var description: String {
        if let turnDegrees = degrees {
            return "Turn \(turnDegrees) degrees."
        }
        return "Turn \(String(describing: variableName)) degrees."
    }
    
    init(degrees: Int) {
        self.degrees = degrees
    }
    
    init(variableName: String){
        self.variableName = variableName
    }
    
    func interpret(turtle: Turtle, context: Context) -> Int? {
        if let value = degrees {
            turtle.turn(degrees: value)
            return value
        }
        if let name = variableName, let value = context.getValue(for: name) {
            turtle.turn(degrees: value)
            return value
        }
        return 0
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}
