//
//  Turn.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Turn: Statement, Expression {
    
    private(set) var degrees: Int!
    private(set) var variableName: String?
    
    var description: String {
        if let turnDegrees = degrees {
            return "Turn \(turnDegrees) degrees."
        }
        return "Turn \(String(describing: variableName)) degrees."
    }
    
    init(degrees: Int) {
        self.degrees = degrees
    }
    
    init(variableName: String){
        self.variableName = variableName
    }
    
    func interpret(context: Context) -> Int? {
        if let value = degrees {
            return value
        }
        if let name = variableName, let value = context.getValue(for: name) {
            return value
        }
        return nil
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}
