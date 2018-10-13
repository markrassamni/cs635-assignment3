//
//  Statement.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/12/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

protocol Statement: CustomStringConvertible {
    var description: String { get } // Swift toString()
//    func interpret(turtle: Turtle, context: Context)
    //    func accept(visitor: Vistor) // TODO: Add visitor acceptance after creating visitor class
}
