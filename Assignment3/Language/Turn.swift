//
//  Turn.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Turn: Statement {
    
    let degrees: Value
    
    var description: String {
        return "Turn \(degrees) degrees."
    }
    
    init(value: Value) {
        self.degrees = value
    }
    
    func interpret(turtle: Turtle, context: Context) {
        guard let degrees = degrees.evaluate(context: context) else { return }
        turtle.turn(degrees: degrees)
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}
