//
//  Memento.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/13/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Memento {
    
    private(set) var direction: Int
    private(set) var location: Point
    private(set) var isPenDown: Bool
    
    init(direction: Int, location: Point, isPenDown: Bool) {
        self.direction = direction
        self.location = location
        self.isPenDown = isPenDown
    }
    
    // TODO: Be able to call with turtle?
    convenience init(turtle: Turtle) {
        self.init(direction: turtle.currentDirection, location: turtle.currentLocation, isPenDown: turtle.isPenDown)
    }
}

extension Memento: Equatable {
    public static func == (lhs: Memento, rhs: Memento) -> Bool {
        return lhs.direction == rhs.direction && lhs.isPenDown == rhs.isPenDown &&
            abs(lhs.location.x - rhs.location.x) < 0.0001 && abs(lhs.location.y - rhs.location.y) < 0.0001
    }
}
