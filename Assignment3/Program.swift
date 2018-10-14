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
        for statement in statements {
            statement.accept(visitor: visitor)
        }
    }
    
    // TOOD: Need to finish this or remove? if not also remove turtle class var
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
