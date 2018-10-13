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
    
    func move(distance: Int) {
        if isPenDown {
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
}
