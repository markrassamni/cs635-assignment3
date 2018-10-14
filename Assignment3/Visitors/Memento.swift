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
        return NSDictionary(dictionary: lhs.savedState).isEqual(to: rhs.savedState)
    }
}
