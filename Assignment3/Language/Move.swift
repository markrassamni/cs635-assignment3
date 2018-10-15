//
//  Move.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Move: Statement {
    
//    private(set) var distance: Int!
//    private(set) var variableName: String?

    private(set) var value: Value
    
    var description: String {
//        if let dist = distance {
//            return "Move \(dist) units."
//        }
//        return "Move \(String(describing: variableName)) units."
        return "Move \(value)"
    }
    
    init(value: Value) {
        self.value = value
    }
    
//    init?(distance: Int){
//        guard distance > 0 else { return nil }
//        self.distance = distance
//    }
//
//    init(variableName: String) {
//        self.variableName = variableName
//    }
    
    func interpret(turtle: Turtle, context: Context) -> Int? {
        guard let interpretedValue = value.interpret(turtle: turtle, context: context) else { return 0 }
        turtle.move(distance: interpretedValue)
        return interpretedValue
        
        /*
        if let value = distance {
            turtle.move(distance: value)
            return value
        } else if let name = variableName, let value = context.getValue(for: name) {
            turtle.move(distance: value)
            return value
        }
        return 0
 */
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}
