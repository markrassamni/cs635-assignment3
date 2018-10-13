//
//  FileParser.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class FileParser {
    
    let lines: [String]
    private let moveCommand = "move"
    private let penUpCommand = "penUp"
    private let penDownCommand = "penDown"
    private let turnCommand = "turn"
    private let repeatCommand = "repeat"
    private let endRepeat = "end"
    private let assignment = "#"
    
    
    // TODO: Change to remove init. parse func takes file as parameter and does all operations
    init?(file: String) {
        guard let filePath = Bundle.main.path(forResource: file, ofType: nil) else { return nil }
        do {
            let data = try String(contentsOfFile: filePath, encoding: .utf8)
            self.lines = data.components(separatedBy: .newlines)
        } catch {
            return nil
        }
    }
    
    func parse() -> [Statement]? {
        return convertToStatements(lines: lines)
    }
    
    // If a single line is failed to be converted to a statement, function will return no previous statements
    private func convertToStatements(lines: [String]) -> [Statement]? {
        var currentLine = 0
        var statements = [Statement]()
        
        // Have to do lines.count-1 because all files created in xcode (used to create .txt files) have an empty line at the end of file. Trying to read the empty line will return nil
        while currentLine < lines.count - 1 {
            let line = lines[currentLine] // combine this and current expr... add .comp sep by here, dont put .first here, switch line.first, refactor inside cases to use line instead of guarding stuff
            guard var currentStatement = line.components(separatedBy: " ").first else { return nil }
            guard let firstChar = currentStatement.first else { return nil }
            if String(firstChar).lowercased() == assignment.lowercased() {
                currentStatement = assignment
            }
            currentStatement = currentStatement.lowercased()
            switch currentStatement {
            case moveCommand.lowercased():
                currentLine += 1
                guard line.components(separatedBy: " ").count == 2 else { return nil }
                let value = line.components(separatedBy: " ")[1]
                if let distance = Int(value){
                    statements.append(Move(distance: distance))
                } else {
                    statements.append(Move(variableName: value))
                }
            case penUpCommand.lowercased():
                currentLine += 1
                statements.append(PenUp())
            case penDownCommand.lowercased():
                currentLine += 1
                statements.append(PenDown())
            case turnCommand.lowercased():
                currentLine += 1
                guard line.components(separatedBy: " ").count == 2 else { return nil }
                let value = line.components(separatedBy: " ")[1]
                if let degrees = Int(value){
                    statements.append(Turn(degrees: degrees))
                } else {
                    statements.append(Turn(variableName: value))
                }
            case repeatCommand.lowercased():
                guard line.components(separatedBy: " ").count == 2 else { return nil }
                let repeatCount = line.components(separatedBy: " ")[1]
                let optionalEndIndex = lines[currentLine..<lines.count].enumerated().filter {$0.element.lowercased() == endRepeat.lowercased()}.map{$0.offset}.first
                guard let endIndex = optionalEndIndex else { return nil }
                currentLine = endIndex + 1
                let repeatedLines = lines.enumerated().filter{$0.offset > currentLine && $0.offset < endIndex }.map{$0.element}
                guard let repeatedStatements = convertToStatements(lines: repeatedLines) else { return nil }
                if let count = Int(repeatCount){
                    statements.append(Repeat(statements: repeatedStatements, repeatCount: count))
                } else {
                    statements.append(Repeat(statements: repeatedStatements, variableName: repeatCount))
                }
            case assignment:
                currentLine += 1
                statements.append(Assignment(name: line))
            default:
                return nil
            }
        }
        return statements
    }
}
