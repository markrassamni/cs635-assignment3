//
//  DistanceVisitor.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/13/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class DistanceVisitor: Visitor {
    
    private(set) var distance: Int = 0
    private(set) var isPenDown: Bool = false
    private(set) var context = Context()
    
    // Why do this? Visit program causes it to visit all expressions
    func visit(_ program: Program) {
        program.accept(visitor: self)
    }
    
    func visit(_ penUp: PenUp) {
        isPenDown = false
    }
    
    func visit(_ penDown: PenDown) {
        isPenDown = true
    }
    
    func visit(_ move: Move) {
        guard isPenDown, let change = move.evaluate(values: context) else { return }
        distance += change
    }
    
    func visit(_ assignment: Assignment) {
        context.setValue(for: assignment.variable.name, to: assignment.variable.value)
    }
    
    func visit(_ repeatNode: Repeat) {
        guard let repeatCount = repeatNode.evaluate(values: context) else { return }
        for _ in 0..<repeatCount {
            for statement in repeatNode.statements {
                statement.accept(visitor: self)
            }
        }
    }
    
    func visit(_ turn: Turn) {
        return
    }
}
