//
//  Move.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Move: Statement {

    let value: Value
    
    var description: String {
        return "Move \(value)."
    }
    
    init(value: Value) {
        self.value = value
    }
    
    func interpret(turtle: Turtle, context: Context) {
        guard let distance = value.evaluate(context: context) else { return }
        turtle.move(distance: distance)
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}
