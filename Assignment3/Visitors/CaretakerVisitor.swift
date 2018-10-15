//
//  CaretakerVisitor.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/13/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class CaretakerVisitor: Visitor {
    
    private(set) var turtle: Turtle
    private(set) var context: Context
    private(set) var mementos: [Memento]

    init(turtle: Turtle, context: Context) {
        self.turtle = turtle
        self.context = context
        mementos = [Memento]()
        saveState()
    }
    
    func visit(_ program: Program){
        for statement in program.statements {
            statement.accept(visitor: self)
        }
    }
    
    func visit(_ penUp: PenUp){
        turtle.penUp()
        saveState()
    }
    
    func visit(_ penDown: PenDown){
        turtle.penDown()
        saveState()
    }
    
    func visit(_ move: Move){
        guard let value = move.value.evaluate(context: context) else { return }
        turtle.move(distance: value)
        saveState()
    }
    
    func visit(_ turn: Turn){
        guard let value = turn.value.evaluate(context: context) else { return }
        turtle.turn(degrees: value)
        saveState()
    }
    
    func visit(_ repeatNode: Repeat){
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
    
    func saveState() {
        mementos.append(turtle.createMemento())
    }
    
    func restoreState(from memento: Memento){
        turtle.restoreState(from: memento)
    }
}
