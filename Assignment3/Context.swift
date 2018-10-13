//
//  Context.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Context {
    
    private (set) var values = Dictionary<String, Int>()
    
    func getValue(for name: String) -> Int? {
        return values[name]
    }
    
    func setValue(for name: String, to value: Int){
        values[name] = value
    }
}
