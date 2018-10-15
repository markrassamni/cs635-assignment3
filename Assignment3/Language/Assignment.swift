//
//  Assignment.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Assignment: Statement {
    
    private(set) var variable: Variable
    private(set) var value: Int
 
    var description: String {
        return "Assign \(variable.name) to \(value)."
    }
    
//    init(variable: (name: String, value: Int)) {
//        self.variable = variable
//    }
//
//    convenience init(name: String, value: Int){
//        self.init(variable: (name: name, value: value))
//    }
    
    init(variable: Variable, value: Int) {
        self.variable = variable
        self.value = value
    }
    
    func interpret(turtle: Turtle, context: Context) -> Int? {
//        guard let interpretedValue = variable.interpret(turtle: turtle, context: context) else { return nil }
        context.setValue(for: variable.name, to: value)
        return nil
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}
