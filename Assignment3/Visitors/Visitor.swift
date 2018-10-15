//
//  Visitor.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/13/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

// TODO: Change back to protocol
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
        turtle.penUp()
    }
    
    func visit(_ penDown: PenDown){
        turtle.penDown()
    }
    
    func visit(_ move: Move){
        guard let value = move.value.evaluate(context: context) else { return }
        turtle.move(distance: value)
    }
    
    func visit(_ turn: Turn){
        guard let value = turn.value.evaluate(context: context) else { return }
        turtle.turn(degrees: value)
    }
    
    func visit(_ repeatNode: Repeat){
        // FIXME: Calling repeat.interpret to get value and for loop here repeat times causes double execution of the repeat block on the same turtle
        guard let repeatCount = repeatNode.value.evaluate(context: context) else { return }
        for _ in 0..<repeatCount {
            for statement in repeatNode.statements {
                statement.accept(visitor: self)
            }
        }
    }

    func visit(_ assignment: Assignment){
        context.setValue(for: assignment.variable.name, to: assignment.value)
    }
}
