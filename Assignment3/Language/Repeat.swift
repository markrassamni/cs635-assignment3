//
//  Repeat.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Repeat: Statement {
    
//    private(set) var count: Int!
//    private(set) var variableName: String?
    let statements: [Statement]
    private(set) var value: Value
    
    var description: String {
//        if let repeatcount = count {
//            return "Repeat \(statements) \(repeatcount) times"
//        }
//        return "Repeat \(statements) \(String(describing: variableName)) times."
        return "Repeat \(statements) \(value) times."
    }
    
//    init(statements: [Statement], repeatCount count: Int){
//        self.statements = statements
//        self.count = count
//    }
//
//    init(statements: [Statement], variableName: String) {
//        self.statements = statements
//        self.variableName = variableName
//    }
    
    init(statements: [Statement], value: Value) {
        self.statements = statements
        self.value = value
    }

    func interpret(turtle: Turtle, context: Context) -> Int? {
        guard let interpretedValue = value.interpret(turtle: turtle, context: context) else { return 0 }
//        turtle.move(distance: interpretedValue.value)
        return interpretedValue < 0 ? 0 : interpretedValue
        
        
        
//        let repeatCount: Int
//        if let value = count {
//            repeatCount = value
//        } else if let name = variableName, let value = context.getValue(for: name) {
//            repeatCount = value
//        } else {
//            return nil
//        }
//        return repeatCount < 0 ? 0 : repeatCount
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}
