//
//  Repeat.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Repeat: Statement {
    
    private(set) var count: Int!
    private(set) var variableName: String?
    let statements: [Statement]
    
    var description: String {
        if let repeatcount = count {
            return "Repeat \(statements) \(repeatcount) times"
        }
        return "Repeat \(statements) \(String(describing: variableName)) times."
    }
    
    init(statements: [Statement], repeatCount count: Int){
        self.statements = statements
        self.count = count
    }
    
    init(statements: [Statement], variableName: String) {
        self.statements = statements
        self.variableName = variableName
    }
    
    func evaluate(values: Context) -> Int? {
        if let repeatCount = count {
            if repeatCount < 1 {
                return 0
            }
            return repeatCount
        }
        if let name = variableName, let repeatCount = values.getValue(for: name) {
            if repeatCount < 1 {
                return 0
            }
            return repeatCount
        }
        return nil
        
        // TODO: Test replacing above code with this:
        /*
        let repeatCount: Int
        if let value = count {
            repeatCount = value
        }
        if let name = variableName, let value = values.getValue(for: name) {
            repeatCount = value
        }
        return repeatCount < 1 ? 0 : repeatCount
        */
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}
