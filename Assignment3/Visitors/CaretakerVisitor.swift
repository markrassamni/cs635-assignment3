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
    
    func visit(_ program: Program){
        for statement in program.statements {
            statement.accept(visitor: self)
        }
    }
    
    func visit(_ penUp: PenUp){
        turtle.penUp()
        mementos.append(createMemento())
    }
    
    func visit(_ penDown: PenDown){
        turtle.penDown()
        mementos.append(createMemento())
    }
    
    func visit(_ move: Move){
        guard turtle.isPenDown, let change = move.evaluate(values: context) else { return }
        turtle.move(distance: change)
        mementos.append(createMemento())
    }
    
    func visit(_ turn: Turn){
        guard let degrees = turn.evaluate(values: context) else { return }
        turtle.turn(degrees: degrees)
        mementos.append(createMemento())
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
    
    func createMemento() -> Memento{
        let direction = turtle.currentDirection
        let location = turtle.currentLocation
        let isPenDown = turtle.isPenDown
        return Memento(direction: direction, location: location, isPenDown: isPenDown)
    }
}
