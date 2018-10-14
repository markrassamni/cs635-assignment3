//
//  Visitor.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/13/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

// TODO: Refactor to have Visitor as a class that implements several methods, sub vis inherit from, dont have to double implement methods
protocol Visitor {
    var context: Context { get }
    func visit(_ program: Program)
    func visit(_ penUp: PenUp)
    func visit(_ penDown: PenDown)
    func visit(_ move: Move)
    func visit(_ turn: Turn)
    func visit(_ repeat: Repeat)
    func visit(_ assignment: Assignment)
}
