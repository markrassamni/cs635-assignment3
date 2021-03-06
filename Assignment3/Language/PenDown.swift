//
//  PenDown.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class PenDown: Statement {
    
    let description = "Pen placed down."
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
    
    func interpret(turtle: Turtle, context: Context) {
        turtle.penDown()
    }
}
