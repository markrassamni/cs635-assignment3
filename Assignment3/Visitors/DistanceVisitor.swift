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
    
    override func visit(_ move: Move) {
        // TODO instead of move.interpret do move.value.evaluate, same in other visitors
        guard let change = move.interpret(turtle: turtle, context: context) else { return }
        distance += change
    }
}
