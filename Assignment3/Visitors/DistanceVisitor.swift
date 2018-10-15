//
//  DistanceVisitor.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/13/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class DistanceVisitor: Visitor {
    
    private(set) var turtle: Turtle
    private(set) var context: Context
    private(set) var distance: Int
    
    init(turtle: Turtle, context: Context) {
        self.turtle = turtle
        self.context = context
        distance = 0
    }
    
    func visit(_ penUp: PenUp){
        turtle.penUp()
    }
    
    func visit(_ penDown: PenDown){
        turtle.penDown()
    }
    
    func visit(_ move: Move) {
        guard let change = move.value.evaluate(context: context), turtle.isPenDown else { return }
        distance += change
    }
    
    func visit(_ turn: Turn){
        return
    }
    
    func visit(_ assignment: Assignment){
        context.setValue(for: assignment.variable.name, to: assignment.value)
    }
}
