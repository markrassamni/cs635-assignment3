//
//  Move.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Move: Statement { // TODO: Also conform to expression when call takes a #/vars?
    
    // TODO: Should change to lets?
    private(set) var distance: Int!
    private(set) var variableName: String?
 
    var description: String {
        if let dist = distance {
            return "Move \(dist) units."
        }
        return "Move \(String(describing: variableName)) units."
    }
    
    init?(distance: Int){
        guard distance > 0 else { return nil }
        self.distance = distance
    }
    
    init(variableName: String) {
        self.variableName = variableName
    }

    // TODO: Change evaluate methods in all statements to "interpret"
    func evaluate(values: Context) -> Int? {
        if let value = distance {
            return value
        }
        if let name = variableName, let value = values.getValue(for: name), value > 0 {
            return value
        }
        return nil
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}
