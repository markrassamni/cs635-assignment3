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
    private(set) var turtle: Turtle
    private(set) var context: Context
    
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
    
    // TODO: be able to do statement.interpret on a repeat and work properly
    func execute(){
        interpret(statements: statements)
    }
    
    private func interpret(statements: [Statement], repeatCount: Int = 1){
        for _ in 0..<repeatCount {
            for statement in statements {
                let value = statement.interpret(turtle: turtle, context: context)
                guard let repeatStatements = (statement as? Repeat)?.statements, let count = value else { continue }
                interpret(statements: repeatStatements, repeatCount: count)
            }
        }
    }
}
