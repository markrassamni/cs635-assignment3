//
//  FileParser.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class FileParser {
    
    private(set) var lines: [String]?
    private let moveCommand = "move"
    private let penUpCommand = "penUp"
    private let penDownCommand = "penDown"
    private let turnCommand = "turn"
    private let repeatCommand = "repeat"
    private let endRepeat = "end"
    private let assignment = "#"
    
    func parse(file: String) -> Program? {
        guard let filePath = Bundle.main.path(forResource: file, ofType: nil) else { return nil }
        do {
            let data = try String(contentsOfFile: filePath, encoding: .utf8)
            self.lines = data.components(separatedBy: .newlines)
        } catch { return nil }
        guard let lines = self.lines else { return nil }
        guard let statements = convertToStatements(lines: lines) else { return nil }
        return buildProgram(fromStatements: statements)
    }
    
    // If a single line is failed to be converted to a statement, function will return no previous statements
    private func convertToStatements(lines: [String]) -> [Statement]? {
        var currentLine = 0
        var statements = [Statement]()
        while currentLine < lines.count {
            let lineComponents = lines[currentLine].components(separatedBy: " ").filter{ $0 != "" }
            guard var statementType = lineComponents.first else {
                // This allows skipping blank lines. Necessary because when using .txt files in xcode (or any file) it will automatically add an empty line to the last line of the file that cannot be removed.
                currentLine += 1
                continue
            }
            guard let firstChar = statementType.first else { return nil }
            if String(firstChar).lowercased() == assignment.lowercased() {
                statementType = assignment
            }
            statementType = statementType.lowercased()
            switch statementType {
            case moveCommand.lowercased():
                currentLine += 1
                guard lineComponents.count == 2 else { return nil }
                let value = lineComponents[1]
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
                guard lineComponents.count == 2 else { return nil }
                let value = lineComponents[1]
                if let degrees = Int(value){
                    statements.append(Turn(degrees: degrees))
                } else {
                    statements.append(Turn(variableName: value))
                }
            case repeatCommand.lowercased():
                guard lineComponents.count == 2 else { return nil }
                let repeatCount = lineComponents[1]
                let optionalEndIndex = lines[currentLine..<lines.count].enumerated().filter {$0.element.lowercased() == endRepeat.lowercased()}.map{$0.offset}.first
                guard let endIndex = optionalEndIndex else { return nil }
                let repeatedLines = lines.enumerated().filter{$0.offset > currentLine && $0.offset < endIndex }.map{$0.element}
                currentLine = endIndex + 1
                guard let repeatedStatements = convertToStatements(lines: repeatedLines) else { return nil }
                if let count = Int(repeatCount){
                    statements.append(Repeat(statements: repeatedStatements, repeatCount: count))
                } else {
                    statements.append(Repeat(statements: repeatedStatements, variableName: repeatCount))
                }
            case assignment:
                currentLine += 1
                guard let variable = lineComponents.first else { return nil }
                statements.append(Assignment(name: variable))
            default:
                return nil
            }
        }
        return statements
    }
    
    private func buildProgram(fromStatements statements: [Statement]) -> Program {
        let ast = Program()
        for statement in statements {
            ast.add(statement: statement)
        }
        return ast
    }
}
