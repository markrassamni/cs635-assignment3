//
//  Assignment.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Assignment: Statement, Expression {
    
    // #K = Y
//    Y is an integer. The variable $K can be used in move, turn and repeat commands.
    private(set) var name: String
    
    private(set) var tuple: (name: String, value: Int)!
    
    var description: String {
        return "Assign \(name) as a variable."
    }
    
    func evaluate(values: Context) -> Int? {
        return values.getValue(for: name)
    }
    
    init(name: String) {
        self.name = name
    }
    
    
}
