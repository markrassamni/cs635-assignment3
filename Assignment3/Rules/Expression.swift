//
//  Expression.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/2/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

protocol Expression: CustomStringConvertible {
    var description: String { get } // Swift toString()
    func evaluate(values: [String:Expression]) -> (x: Double, y: Double)
}
