//
//  PenUp.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class PenUp: Expression {
    
    // When the pen is up and the turtle moves nothing is drawn.
    
    /*
    func evaluate(values: [String : Expression]) -> Location {
        return Location(x: 0.0, y: 0.0, position: (x: 0.0, y: 0.0), rotation: 0.0)
    }
 */
    func evaluate(values: Context) {
        
    }
    
    
    var description: String {
        return "Pen picked up."
    }
    
//    func evaluate(values: Context) -> Bool {
//        return true
//    }
    
    
    
    
    
}
