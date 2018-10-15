//
//  Assignment.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Assignment: Statement {
    
    let variable: Variable
    let value: Int
 
    var description: String {
        return "Assign \(variable.name) to \(value)."
    }
    
    init(variable: Variable, value: Int) {
        self.variable = variable
        self.value = value
    }
    
    func interpret(turtle: Turtle, context: Context) {
        context.setValue(for: variable.name, to: value)
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}
