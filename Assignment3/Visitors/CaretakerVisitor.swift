//
//  CaretakerVisitor.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/13/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class CaretakerVisitor: Visitor {
    
    private(set) var mementos: [Memento]
    let turtle: Turtle
    let context: Context

    init(turtle: Turtle, context: Context) {
        self.turtle = turtle
        self.context = context
        mementos = [Memento]()
        saveState()
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
        guard let value = move.distance.evaluate(context: context) else { return }
        turtle.move(distance: value)
        saveState()
    }
    
    func visit(_ turn: Turn){
        guard let value = turn.degrees.evaluate(context: context) else { return }
        turtle.turn(degrees: value)
        saveState()
    }
    
    func visit(_ assignment: Assignment){
        context.setValue(for: assignment.variable.name, to: assignment.value)
    }
    
    private func saveState() {
        mementos.append(turtle.createMemento())
    }
    
    private func restoreState(from memento: Memento){
        turtle.restoreState(from: memento)
    }
}
