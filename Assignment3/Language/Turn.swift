//
//  Turn.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Turn: Statement {
    
//    private(set) var degrees: Int!
//    private(set) var variableName: String?
    var value: Value
    
    var description: String {
//        if let turnDegrees = degrees {
//            return "Turn \(turnDegrees) degrees."
//        }
//        return "Turn \(String(describing: variableName)) degrees."
        return "Turn \(value) degrees"
    }
    
    init(value: Value) {
        self.value = value
    }
    
//    init(degrees: Int) {
//        self.degrees = degrees
//    }
//
//    init(variableName: String){
//        self.variableName = variableName
//    }
//
    func interpret(turtle: Turtle, context: Context) -> Int? {
        guard let interpretedValue = value.interpret(turtle: turtle, context: context) else { return 0 }
        turtle.turn(degrees: interpretedValue)
        return interpretedValue
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}
