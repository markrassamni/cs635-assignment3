//
//  Constant.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/14/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Constant: Value {
    
    let value: Int
    
    var description: String {
        return "\(value)"
    }
    
    init(_ value: Int) {
        self.value = value
    }
    
    func evaluate(context: Context) -> Int? {
        return value
    }
}
