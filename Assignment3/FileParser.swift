//
//  FileParser.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class FileParser {
    
    private(set) var currentLine = 0
    let lines: [String]
    
    private let moveCommand = "move"
    private let penUpCommand = "penUp"
    private let penDownCommand = "penDown"
    private let turnCommand = "turn"
    private let repeatCommand = "repeat"
    private let endRepeat = "end"
    private let variableInit = "#"
    
    
    init?(file: String) {
        guard let filePath = Bundle.main.path(forResource: file, ofType: nil) else { return nil }
        do {
        let data = try String(contentsOfFile: filePath, encoding: .utf8)
            self.lines = data.components(separatedBy: .newlines)
        } catch {
            return nil
        }
    }
    
    // pass in array of string expressions and return array of [expression]
    
    // change to parse lines passed in as parameter, another function calls this one line at a time, if func is repeat etc call with lines in repeat block
    func parseNextCommand() -> Expression? {
        // How to handle end of file? only check lines.count lines for currentLine 
        // store in class where we are in file, then read next line here
        
        let line = lines[currentLine] // combine this and current expr... add .comp sep by here, dont put .first here, switch line.first, refactor inside cases to use line instead of guarding stuff
        
        // Need to Increment currentLine accordingly
        
        guard var currentExpression = line.components(separatedBy: " ").first else { return nil }
        
        //Insert space after # in variable to handle reading value in switch below
        if currentExpression.first == "#"{ //also make sure it is only 1 word. do not want #side 12 421 man
            let name = currentExpression.dropFirst()
            currentExpression = "# \(name)"
        } else {
            currentExpression = currentExpression.lowercased()
        }
        
        
        switch currentExpression {
        case moveCommand.lowercased():
            currentLine += 1
            guard line.components(separatedBy: " ").count == 2 else { return nil }
            let value = line.components(separatedBy: " ")[1]
            
            if let distance = Int(value){
                return Move(distance: distance)
            } else {
                // variable, string
            }
        case penUpCommand.lowercased():
            currentLine += 1
            return PenUp()
        case penDownCommand.lowercased():
            currentLine += 1
            return PenDown()
        case turnCommand.lowercased():
            currentLine += 1
            guard line.components(separatedBy: " ").count == 2 else { return nil }
            let value = line.components(separatedBy: " ")[1]
            
            if let degrees = Int(value){
                return Turn(degrees: degrees)
            } else {
                // variable, string
            }
        case repeatCommand.lowercased():
            //Find the line on which this repeat block ends
            let endIndex = lines[currentLine..<lines.count].enumerated().filter{$0.element.lowercased() == endRepeat.lowercased() }.map{$0.offset}.first
            guard let endLine = endIndex else { return nil }
            
            let repeatedLines = lines.enumerated().filter{$0.offset > currentLine && $0.offset < endLine }.map{$0.element}
            print(repeatedLines)
            
            //Do not guard this... count = 1 not 2, counting repeat line not command body line. nvm repeat has a count
            guard line.components(separatedBy: " ").count == 2 else { return nil } //TODO: move to top of case
            let value = line.components(separatedBy: " ")[1]
            
            if let count = Int(value){
                // Need to parse repeated lines and create expressions instead of passing a string to repeat command
//                return Repeat(expressions: repeatedLines, repeatCount: count)
                print(count)
            } else {
                // variable, string
                print("variable")
            }
        case variableInit:
            currentLine += 1
            guard let index = (line.range(of: variableInit)?.upperBound) else { return nil }
            let name = String(line.suffix(from: index))
            let _ = Variable(name: name)
            
            
        default:
            return nil
        }
        
        
        /*
        if line.contains(moveCommand) {
            // Remove everything before the number in the expression
            guard let index = (line.range(of: "\(moveCommand) ")?.upperBound) else { return nil }
            guard let count = Int(line.suffix(from: index)) else { return nil } // dont return nil, will be variable
            print(count)
            // return Move(count)
        } else if line.contains(penUpCommand){
            return PenUp()
        } else if line.contains(penDownCommand){
            return PenDown()
        } else if line.contains(turnCommand){
            // Remove everything before the number in the expression
            guard let index = (line.range(of: "\(turnCommand) ")?.upperBound) else { return nil }
            guard let count = Int(line.suffix(from: index)) else { return nil } // dont return nil, will be a variable
            print(count)
            // return Turn(count)
        } else if line.contains(repeatCommand){
            // have to parse to find "end" and increment currentLine appropriate # times
            // Need to handle all expressions in the repeat, return array of expressions?
            // refactor to call this method with the array
            
            
            //Find the next occurence of "end" and get its index
            let endIndex = lines[currentLine..<lines.count].enumerated().filter{$0.element == endRepeat }.map{$0.offset}.first
            guard let endLine = endIndex else { return nil }
            let repeatedLines = lines[currentLine+1..<endLine]
            print(repeatedLines)
            
            
            guard let index = (line.range(of: "\(repeatCommand) ")?.upperBound) else { return nil }
            guard let count = Int(line.suffix(from: index)) else { return nil } // dont return nil, will be variable
            print(count)
            //Repeat(count, expressions)
            
            
            

        } else if line.contains(variableInit){
            guard let index = (line.range(of: variableInit)?.upperBound) else { return nil }
            let name = String(line.suffix(from: index))
            let _ = Variable(name: name)
        } else {
            // line contains predefined variable
            //nvm should have commend before var, need to handle if line has var instead of number in ifs above
        }
        */
        
        
        return nil
    }

    
}

fileprivate extension String {
    func contains(_ string: String) -> Bool{
        return self.range(of: string, options: .caseInsensitive) != nil
    }
}
