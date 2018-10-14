//
//  Turn.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Turn: Statement {
    
    
    
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
    
    // Turn the direction of the turtle X degrees.
    /*
    var leftOperand: Expression
    var rightOperand: Expression
    
    init(leftOperand: Expression, rightOperand: Expression) {
        self.leftOperand = leftOperand
        self.rightOperand = rightOperand
    }
 */
    
    func evaluate(values: Context) -> Int? {
        return 0
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
    
    /*
    func evaluate(values: [String : Expression]) -> (x: Double, y: Double) {
        let x = leftOperand.evaluate(values: values).x + rightOperand.evaluate(values: values).x
        let y = leftOperand.evaluate(values: values).y + rightOperand.evaluate(values: values).y
        return (x, y)
    }
 
 func evaluate(values: [String : Expression]) -> Location {
 return Location(x: 0, y: 0, position: (0.0, 0.0), rotation: 0.0)
 }
 */
    
}
