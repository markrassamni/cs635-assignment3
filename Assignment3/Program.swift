//
//  Program.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/11/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Program{
    
    private(set) var statements: [Statement]
    let turtle: Turtle
    let context: Context
    
    init() {
        self.statements = [Statement]()
        self.turtle = Turtle()
        self.context = Context()
    }
 
    func add(statement: Statement){
        statements.append(statement)
    }
    
    func accept(visitor: Visitor){
        visitor.visit(self)
    }
    
    func interpret(){
        for statement in statements {
            statement.interpret(turtle: turtle, context: context)
        }
    }
}
