//
//  Turtle.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Turtle{
    
    private(set) var currentDirection: Int = 0
    private(set) var currentLocation = Point(x: 0.0, y: 0.0)
    private(set) var isPenDown = false
    
    let directionState = "direction"
    let locationState = "location"
    let penDownState = "penDownState"
    
    func move(distance: Int) {
        if isPenDown && distance > 0 {
            let radians = Double(currentDirection) * .pi / 180
            let deltaX = cos(radians) * Double(distance)
            let deltaY = sin(radians) * Double(distance)
            currentLocation = Point(x: currentLocation.x + deltaX, y: currentLocation.y + deltaY)
        }
    }
    
    func turn(degrees: Int){
        currentDirection += degrees
    }
    
    func penUp(){
        isPenDown = false
    }
    
    func penDown(){
        isPenDown = true
    }
    
    func isPenUp() -> Bool {
        return !isPenDown
    }
    
    func direction() -> Int {
        return currentDirection
    }
    
    func location() -> Point {
        return currentLocation
    }
    
    func restoreState(from memento: Memento){
        if let location = memento.getState(name: locationState) as? Point{
            currentLocation = location
        }
        if let direction = memento.getState(name: directionState) as? Int {
            currentDirection = direction
        }
        if let penDown = memento.getState(name: penDownState) as? Bool {
            isPenDown = penDown
        }
    }
    
    func createMemento() -> Memento {
        let currentState = Memento()
        currentState.setState(name: locationState, value: currentLocation)
        currentState.setState(name: directionState, value: currentDirection)
        currentState.setState(name: penDownState, value: isPenDown)
        return currentState
    }
}

extension Turtle: Equatable {
    static func == (lhs: Turtle, rhs: Turtle) -> Bool {
        return lhs.isPenDown == rhs.isPenDown && lhs.currentLocation == rhs.currentLocation && lhs.currentDirection == rhs.currentDirection
    }
}
