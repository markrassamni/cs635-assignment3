//
//  CaretakerVisitor.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/13/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class CaretakerVisitor: Visitor {
    
    private(set) var context = Context()
    private(set) var mementos: [Memento]
    private(set) var turtle = Turtle()
    
    // How to handle this? Should pass starting values to visitor?
    init(startDirection: Int, startLocation: Point, doesPenStartDown: Bool) {
        mementos = [Memento(direction: startDirection, location: startLocation, isPenDown: doesPenStartDown)]
    }
    
    func visit(_ program: Program) {
        program.accept(visitor: self)
    }
    
    func visit(_ penUp: PenUp){
        
        turtle.penUp()
        let memento = createMemento()
        mementos.append(memento)
        
        /*
        guard let direction = mementos.last?.direction else { return }
        guard let location = mementos.last?.location else { return }
        let memento = Memento(direction: direction, location: location, isPenDown: false)
        mementos.append(memento)
         */
    }
    
    func visit(_ penDown: PenDown){
        guard let direction = mementos.last?.direction else { return }
        guard let location = mementos.last?.location else { return }
        let memento = Memento(direction: direction, location: location, isPenDown: true)
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
    
    func createMemento() -> Memento{
        let direction = turtle.currentDirection
        let location = turtle.currentLocation
        let isPenDown = turtle.isPenDown
        return Memento(direction: direction, location: location, isPenDown: isPenDown)
    }
}
