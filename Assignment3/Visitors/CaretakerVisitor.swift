//
//  CaretakerVisitor.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/13/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class CaretakerVisitor: Visitor {
    
    private(set) var mementos = [Memento]()

    override init(turtle: Turtle, context: Context) {
        super.init(turtle: turtle, context: context)
        saveState()
    }
    
    override func visit(_ penUp: PenUp){
        super.visit(penUp)
        saveState()
    }
    
    override func visit(_ penDown: PenDown){
        super.visit(penDown)
        saveState()
    }
    
    override func visit(_ move: Move){
        super.visit(move)
        saveState()
    }
    
    override func visit(_ turn: Turn){
        super.visit(turn)
        saveState()
    }
    
    func saveState() {
        mementos.append(turtle.createMemento())
    }
    
    func restoreState(from memento: Memento){
        turtle.restoreState(from: memento)
    }
}
