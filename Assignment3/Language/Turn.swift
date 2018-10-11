//
//  Turn.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Turn: Expression {
    
    
    
    private(set) var degrees: Int
    
    var description: String {
        return "Turn \(degrees) degrees."
    }
    
    
    init(degrees: Int) {
        self.degrees = degrees
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
    
    func evaluate(values: Context) {
        
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
