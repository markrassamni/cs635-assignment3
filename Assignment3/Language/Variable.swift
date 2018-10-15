//
//  Variable.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/14/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Variable: Value {
    
    var name: String
    
    var description: String{
        return "\(name)"
    }
    
    init(name: String) {
        self.name = name
    }
    
    func evaluate(context: Context) -> Int? {
        return context.getValue(for: name)
    }
}
