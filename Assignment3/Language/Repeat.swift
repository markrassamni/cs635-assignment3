//
//  Repeat.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Repeat: Expression {
    
    private(set) var expressions: [Expression]
    private(set) var count: Int
    
    var description: String {
        return "Repeat \(expressions) \(count) times" 
    }
    
    
    init(expressions: [Expression], repeatCount count: Int){
        self.expressions = expressions
        self.count = count
    }
    
    func evaluate(values: Context) {
        
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
