//
//  Statement.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/12/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

protocol Statement: CustomStringConvertible {
    var description: String { get }
    func accept(visitor: Visitor)
    func interpret(turtle: Turtle, context: Context)
}
