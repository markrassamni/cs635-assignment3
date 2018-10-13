//
//  Repeat.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Repeat: Statement {
    
    let statements: [Statement]
    private(set) var count: Int!
    private(set) var variableName: String?
    
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
    
    func evaluate(values: Context) {
        // check if count >0, otherwise do nothing
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
    
    /*
     repeat k
     statement1
     statement2
     ...
     statementJ
     end
 
 */
    
    // k is an integer. The statements inside the repeat block are any legal statement in the language. the repeat statement has the obvious semantics.
    
}
