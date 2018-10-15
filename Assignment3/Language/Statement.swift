//
//  Statement.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/12/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

// TODO: Rename to Grammar.  and rename expressions to statement?
protocol Statement: CustomStringConvertible {
    var description: String { get } // Swift toString()
    func accept(visitor: Visitor)
    func interpret(turtle: Turtle, context: Context)
}
