//
//  Program.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/11/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Program{
    
    private(set) var statements = [Statement]()
    
    func add(statement: Statement){
        statements.append(statement)
    }
    
    func accept(visitor: Visitor){ 
        for statement in statements {
            statement.accept(visitor: visitor)
        }
    }
}
