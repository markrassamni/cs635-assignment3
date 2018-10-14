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
        switch statement{
        case is PenUp:
            turtle.penUp()
        case is PenDown:
            turtle.penDown()
        case is Move:
            guard let move = statement as? Move else { return }
            guard let value = move.interpret(context: context) else { return }
            turtle.move(distance: value)
        case is Turn:
            guard let turn = statement as? Turn else { return }
            guard let value = turn.interpret(context: context) else { return }
            turtle.turn(degrees: value)
        case is Repeat:
            guard let repeatStatement = statement as? Repeat else { return }
            guard let count = repeatStatement.interpret(context: context) else { return }
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
