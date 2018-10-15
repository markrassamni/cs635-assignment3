//
//  Visitor.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/13/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

protocol Visitor {
    var turtle: Turtle { get }
    var context: Context { get }
    func visit(_ program: Program)
    func visit(_ penUp: PenUp)
    func visit(_ penDown: PenDown)
    func visit(_ move: Move)
    func visit(_ turn: Turn)
    func visit(_ repeatNode: Repeat)
    func visit(_ assignment: Assignment)
}

extension Visitor {
    func visit(_ program: Program){
        for statement in program.statements {
            statement.accept(visitor: self)
        }
    }

    func visit(_ repeatNode: Repeat){
        guard let repeatCount = repeatNode.value.evaluate(context: context) else { return }
        for _ in 0..<repeatCount {
            for statement in repeatNode.statements {
                statement.accept(visitor: self)
            }
        }
    }
}
