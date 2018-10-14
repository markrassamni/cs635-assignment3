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
        guard turtle.isPenDown, let change = move.evaluate(values: context) else { return }
        distance += change
    }
    
    // TODO: Let it turn? Remove override?
    override func visit(_ turn: Turn) {
        return
    }
}
