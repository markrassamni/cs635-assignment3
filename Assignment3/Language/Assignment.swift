//
//  Assignment.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Assignment: Statement {
    
    private(set) var variable: (name: String, value: Int)
    
    var description: String {
        return "Assign \(variable.name) to \(variable.value)."
    }
    
    init(variable: (name: String, value: Int)) {
        self.variable = variable
    }
    
    convenience init(name: String, value: Int){
        self.init(variable: (name: name, value: value))
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}
