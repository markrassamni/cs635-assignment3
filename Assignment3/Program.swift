//
//  Program.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/11/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Program{
    
    private(set) var statements = [Statement]()
    private(set) var turtle = Turtle()
 
    func add(statement: Statement){
        statements.append(statement)
    }
    
    func accept(visitor: Visitor){
        visitor.visit(self)
    }
    
    // TOOD: Need to finish this or remove? if not also remove turtle class var
    // Need to execute without visitor. If we have visitor and we call execute then visitor does its stuff. Above call to accept visitor should not also execute
    func execute(){
        for statement in statements{
            switch statement{
            case is PenUp:
                turtle.penUp()
            default:
                return
            }
        }
    }
}
