//
//  Visitor.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/13/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

protocol Visitor {
    var context: Context { get }
    func visit(_ penUp: PenUp)
    func visit(_ penDown: PenDown)
    func visit(_ move: Move)
    func visit(_ turn: Turn)
    func visit(_ repeat: Repeat)
    func visit(_ assignment: Assignment)
}
