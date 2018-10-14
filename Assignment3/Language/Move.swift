//
//  Move.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Move: Statement {
    
    private(set) var distance: Int!
    private(set) var variableName: String?
 
    var description: String {
        if let dist = distance {
            return "Move \(dist) units."
        }
        return "Move \(String(describing: variableName)) units."
    }
    
    init?(distance: Int){
        guard distance > 0 else { return nil }
        self.distance = distance
    }
    
    init(variableName: String) {
        self.variableName = variableName
    }
    
    // TODO: Figure out how to do this and get a value for visitor
    /*
    func interpret(turtle: Turtle, context: Context) {
        // TODO: around 17:30 video he says how to handle this
        let _: Int? = interpret(turtle: turtle, context: context)
    }
 */
    
    func interpret(turtle: Turtle, context: Context) -> Int? {
        guard turtle.isPenDown else { return 0 } // TODO: Return nil or 0?
        if let value = distance, value > 0 {
            turtle.move(distance: value)
            return value
        } else if let name = variableName, let value = context.getValue(for: name), value > 0 {
            turtle.move(distance: value)
            return value
        }
        return nil
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}
