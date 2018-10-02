//
//  Context.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Context: Hashable {
    
    private (set) var values: Dictionary<String, Int>!
    
    func getValue(for variableName: String) -> Int? {
        return values[variableName] ?? nil
    }
    
    func setValue(variableName: String, value: Int){
        values[variableName] = value
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(values)
    }
    
    static func == (lhs: Context, rhs: Context) -> Bool {
        return lhs.values == rhs.values
    }
    
}
