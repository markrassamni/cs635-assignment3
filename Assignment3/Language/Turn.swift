//
//  Turn.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Turn: Statement {
    
    let value: Value
    
    var description: String {
        return "Turn \(value) degrees."
    }
    
    init(value: Value) {
        self.value = value
    }
    
    func interpret(turtle: Turtle, context: Context) {
        guard let degrees = value.evaluate(context: context) else { return }
        turtle.turn(degrees: degrees)
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}
