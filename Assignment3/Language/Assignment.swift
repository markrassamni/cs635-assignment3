//
//  Assignment.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Assignment: Statement, Expression {
    
    // #K = Y
//    Y is an integer. The variable $K can be used in move, turn and repeat commands.
    
    private(set) var variable: (name: String, value: Int)
    
    var description: String {
        return "Assign \(variable.name) to \(variable.value)."
    }
    
    init(variable: (name: String, value: Int)) {
        self.variable = variable
    }
    
    convenience init(name: String, value: Int){
        self.init(variable: (name: name, value: value))
    }
    
    func evaluate(values: Context) -> Int? {
        return values.getValue(for: variable.name)
    }
    
    func evaluate(context: Context){
        context.setValue(for: variable.name, to: variable.value)
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
    
    
}
