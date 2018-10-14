//
//  Variable.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/14/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

// TODO: Should this be a statement and accept visitor?
class Variable {
    
    var name: String
    
    var description: String{
        return "Variable \(name)"
    }
    
    init(name: String) {
        self.name = name
    }
    
//    func accept(visitor: Visitor) {
//        visitor.visit(self)
//    }
    
    func interpret(turtle: Turtle, context: Context) -> Int? {
        return context.getValue(for: name)
    }
}
