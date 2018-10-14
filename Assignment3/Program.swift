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
    private(set) var turtle = Turtle()
    private(set) var context = Context()
 
    func add(statement: Statement){
        statements.append(statement)
    }
    
    func accept(visitor: Visitor){
        visitor.visit(self)
    }
    
    // Need to execute without visitor. If we have visitor and we call execute then visitor does its stuff. Above call to accept visitor should not also execute
    // TODO: Should change this to expressions and call expression.eval? How to handle pen? Remove extra class vars when not needed
    func execute(){
        for statement in statements{
            evaluate(statement: statement)
        }
    }
    
    private func evaluate(statement: Statement){
        
        // TODO: Just do this
//        for statement in statements {
//            statement.interpret(turtle: turtle, context: context)
//        }
        switch statement{
        case is PenUp:
            turtle.penUp()
        case is PenDown:
            turtle.penDown()
        case is Move:
            guard let move = statement as? Move else { return }
            let _ = move.interpret(turtle: turtle, context: context)
        case is Turn:
            guard let turn = statement as? Turn else { return }
            let _ = turn.interpret(turtle: turtle, context: context)
        case is Repeat:
            // TODO: Move this for loop inside repeat.interpret
            guard let repeatStatement = statement as? Repeat else { return }
            guard let count = repeatStatement.interpret(turtle: turtle, context: context) else { return }
            for _ in 0..<count {
                for statement in repeatStatement.statements {
                    evaluate(statement: statement)
                }
            }
        case is Assignment:
            guard let assignment = statement as? Assignment else { return }
            let variable: (name: String, value: Int) = assignment.variable
            context.setValue(for: variable.name, to: variable.value)
        default:
            return
        }
    }
}
