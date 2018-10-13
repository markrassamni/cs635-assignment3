//
//  Move.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Move: Statement { // Also conform to expression when call takes a #/var
    
    
//    var leftOperand: Expression
//    var rightOperand: Expression
    
    // Shoulc change to lets?
    private(set) var distance: Int!
    private(set) var variableName: String?
 
    var description: String {
        if let dist = distance {
            return "Move \(dist) units."
        }
        return "Move \(String(describing: variableName)) units."
    }
    
    init? (distance: Int){
        guard distance > 0 else { return nil }
        self.distance = distance
    }
    
    init(variableName: String) {
        self.variableName = variableName
    }
    
    /*
    init(leftOperand: Expression, rightOperand: Expression) {
        self.leftOperand = leftOperand
        self.rightOperand = rightOperand
    }
 */
    
    // Move the turtle X units in the current direction. X is a positive integer.
    
    /*
    func evaluate(values: [String : Expression]) -> Location {
        let x = leftOperand.evaluate(values: values).x + rightOperand.evaluate(values: values).x
        let y = leftOperand.evaluate(values: values).y + rightOperand.evaluate(values: values).y
//        let location = Location
        let location = Location.init(x: x, y: y, position: (x, y), rotation: 0.0)
        return location
    }
 */
    func evaluate(values: Context) -> Int? {
        if let value = distance {
            return value
        }
        if let name = variableName, let value = values.getValue(for: name) {
            return value
        }
        return nil
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
    
}
