//
//  Visitor.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/13/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Visitor {
    
    private(set) var turtle = Turtle()
    private(set) var context = Context()
    
    init(turtle: Turtle, context: Context) {
        self.turtle = turtle
        self.context = context
    }
    
    func visit(_ program: Program){
        for statement in program.statements {
            statement.accept(visitor: self)
        }
    }
    
    func visit(_ penUp: PenUp){
        let _ = penUp.interpret(turtle: turtle, context: context)
    }
    
    func visit(_ penDown: PenDown){
        let _ = penDown.interpret(turtle: turtle, context: context)
    }
    
    func visit(_ move: Move){
        let _ = move.interpret(turtle: turtle, context: context)
    }
    
    func visit(_ turn: Turn){
        let _ = turn.interpret(turtle: turtle, context: context)
    }
    
    func visit(_ repeatNode: Repeat){
        // FIXME: Calling repeat.interpret to get value and for loop here repeat times causes double execution of the repeat block on the same turtle
        guard let repeatCount = repeatNode.interpret(turtle: turtle, context: context) else { return }
        for _ in 0..<repeatCount {
            for statement in repeatNode.statements {
                statement.accept(visitor: self)
            }
        }
    }
    
    func visit(_ assignment: Assignment){
        context.setValue(for: assignment.variable.name, to: assignment.variable.value)
    }
}
