//
//  Memento.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/13/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Memento {
    
    private(set) var savedState = Dictionary<String, Any>()

    func setState(name: String, value: Any){
        savedState[name] = value
    }
    
    func getState(name: String) -> Any? {
        return savedState[name]
    }
    
    func getState(name: String, defaultValue: Any) -> Any {
        return savedState[name] ?? defaultValue
    }
}

extension Memento: Equatable{
    static func == (lhs: Memento, rhs: Memento) -> Bool {
        let leftArray = Array(lhs.savedState.values)
        let rightArray = Array(rhs.savedState.values)
        guard leftArray.count == rightArray.count else { return false }
        let unEqualLeft = leftArray.enumerated().filter { $0.element as AnyObject !== rightArray[$0.offset] as AnyObject}.map{ $0.element }
        let unEqualRight = rightArray.enumerated().filter { $0.element as AnyObject !== leftArray[$0.offset] as AnyObject}.map { $0.element }
        guard unEqualLeft.count == unEqualRight.count else { return false }
        let leftPoints = unEqualLeft.filter { $0 is Point } as! [Point]
        let rightPoints = unEqualRight.filter { $0 is Point } as! [Point]
        guard leftPoints.count == rightPoints.count && leftPoints.count == unEqualLeft.count else { return false }
        let unEqualPoints = leftPoints.enumerated().filter { abs($0.element.x - rightPoints[$0.offset].x) > 0.0001 && abs($0.element.y - rightPoints[$0.offset].y) > 0.0001 }
        return unEqualPoints.count > 0 ? false : true
    }
}
