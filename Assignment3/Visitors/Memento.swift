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
}
