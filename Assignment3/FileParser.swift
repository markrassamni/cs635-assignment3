//
//  FileParser.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class FileParser {
    
    var currentLine = 0
    let lines: [String]
    
    init?(file: String) {
        guard let filePath = Bundle.main.path(forResource: file, ofType: nil) else { return nil }
        do {
        let data = try String(contentsOfFile: filePath, encoding: .utf8)
            self.lines = data.components(separatedBy: .newlines)
        } catch {
            return nil
        }
    }
    
    // change to parse lines passed in as parameter, another function calls this one line at a time, if func is repeat etc call with lines in repeat block
    func parseNextCommand() -> Expression? {
        // How to handle end of file? only check lines.count lines for currentLine 
        // store in class where we are in file, then read next line here
        
        let line = lines[currentLine]
        
        // Need to Increment currentLine accordingly
        
        if line.contains("move") {
            // Remove everything before the number in the expression
            guard let index = (line.range(of: "move ")?.upperBound) else { return nil }
            guard let count = Int(line.suffix(from: index)) else { return nil } // dont return nil, will be variable
            print(count)
            // return Move(count)
        } else if line.contains("penUp"){
            return PenUp()
        } else if line.contains("penDown"){
            return PenDown()
        } else if line.contains("turn"){
            // Remove everything before the number in the expression
            guard let index = (line.range(of: "turn ")?.upperBound) else { return nil }
            guard let count = Int(line.suffix(from: index)) else { return nil } // dont return nil, will be a variable
            print(count)
            // return Turn(count)
        } else if line.contains("repeat"){
            // have to parse to find "end" and increment currentLine appropriate # times
            // Need to handle all expressions in the repeat, return array of expressions?
            // refactor to call this method with the array
            
            //Find the next occurence of "end" and get its index
            let endIndex = lines[currentLine..<lines.count].enumerated().filter{$0.element == "end"}.map{$0.offset}.first
            guard let endLine = endIndex else { return nil }
            let repeatedLines = lines[currentLine+1..<endLine]
            print(repeatedLines)
            
            
            guard let index = (line.range(of: "repeat ")?.upperBound) else { return nil }
            guard let count = Int(line.suffix(from: index)) else { return nil } // dont return nil, will be variable
            print(count)
            //Repeat(count, expressions)
            
            
            

        } else if line.contains("#"){
            guard let index = (line.range(of: "#")?.upperBound) else { return nil }
            let name = String(line.suffix(from: index))
            let _ = Variable(name: name)
        } else {
            // line contains predefined variable
            //nvm should have commend before var, need to handle if line has var instead of number in ifs above
        }
        
        
        
        return nil
    }

    
}

fileprivate extension String {
    func contains(_ string: String) -> Bool{
        return self.range(of: string, options: .caseInsensitive) != nil
    }
}
