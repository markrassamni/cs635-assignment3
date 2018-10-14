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
        turtle.penUp()
    }
    
    func visit(_ penDown: PenDown){
        turtle.penDown()
    }
    
    func visit(_ move: Move){
        guard turtle.isPenDown, let change = move.evaluate(values: context) else { return }
        turtle.move(distance: change)
    }
    
    func visit(_ turn: Turn){
        guard let degrees = turn.evaluate(values: context) else { return }
        turtle.turn(degrees: degrees)
    }
    
    func visit(_ repeatNode: Repeat){
        guard let repeatCount = repeatNode.evaluate(values: context) else { return }
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
