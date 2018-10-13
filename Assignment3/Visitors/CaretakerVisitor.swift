//
//  CaretakerVisitor.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/13/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class CaretakerVisitor: Visitor {
    
    var turtle: Turtle
    var context: Context
    var mementos = [Memento]()
    
    init(turtle: Turtle, context: Context) {
        self.turtle = turtle
        self.context = context
    }
    
    func visit(_ program: Program) {
        program.accept(visitor: self)
    }
    
    func visit(_ penUp: PenUp){
        let memento = Memento(direction: turtle.direction(), location: turtle.location(), isPenDown: false)
        mementos.append(memento)
    }
    
    func visit(_ penDown: PenDown){
        let memento = Memento(direction: turtle.direction(), location: turtle.location(), isPenDown: true)
        mementos.append(memento)
    }
    
    func visit(_ move: Move){
        
    }
    
    func visit(_ turn: Turn){
        
    }
    
    func visit(_ repeat: Repeat){
        
    }
    
    func visit(_ assignment: Assignment){
        
    }
}
