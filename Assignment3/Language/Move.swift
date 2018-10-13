//
//  Move.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Move: Statement, Expression {
    
    
//    var leftOperand: Expression
//    var rightOperand: Expression
    
    private(set) var distance: Int
    
    var description: String{
        return "Move \(distance) units."
    }
    
    init(distance: Int){
        self.distance = distance
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
        return 0
    }
    
    
}
