//
//  FileParser.swift
//  Assignment3
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class FileParser {
    
    private var lines: [String]?
    private let moveCommand = "move"
    private let penUpCommand = "penUp"
    private let penDownCommand = "penDown"
    private let turnCommand = "turn"
    private let repeatCommand = "repeat"
    private let endRepeat = "end"
    private let assignment = "#"
    
    func buildProgram(fromFile file: String) -> Program? {
        guard let filePath = Bundle.main.path(forResource: file, ofType: nil) else { return nil }
        do {
            let data = try String(contentsOfFile: filePath, encoding: .utf8)
            self.lines = data.components(separatedBy: .newlines)
        } catch { return nil }
        guard let lines = self.lines else { return nil }
        guard let statements = convertToStatements(lines: lines) else { return nil }
        return buildProgram(fromStatements: statements)
    }
    
    // If a single line is failed to be converted to a statement, function will return nil
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
                    statements.append(Move(value: Constant(distance)))
                } else {
                    statements.append(Move(value: Variable(name: value)))
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
                    statements.append(Turn(value: Constant(degrees)))
                } else {
                    statements.append(Turn(value: Variable(name: value)))
                }
            case repeatCommand.lowercased():
                guard lineComponents.count == 2 else { return nil }
                let repeatCount = lineComponents[1]
                // Find the indices of all remaining "end" and "repeat" statements
                var endIndices = lines.enumerated().filter{ $0.element.lowercased().components(separatedBy: " ").filter {$0 != ""}.first == endRepeat.lowercased() && $0.offset > currentLine && $0.offset < lines.count}.map{$0.offset}
                let repeatIndices = lines.enumerated().filter{$0.element.lowercased().components(separatedBy: " ").filter {$0 != ""}.first == repeatCommand.lowercased() && $0.offset > currentLine && $0.offset < lines.count}.map{$0.offset}
                // Disregard "end"s that correspond to a different repeat
                for repeatIndex in repeatIndices {
                    if let index = endIndices.index(where: { $0 > repeatIndex}) {
                        endIndices.remove(at: index)
                    }
                }
                guard let endIndex = endIndices.first else { return nil }
                let repeatedLines = lines.enumerated().filter{$0.offset > currentLine && $0.offset < endIndex && $0.element.lowercased() != endRepeat.lowercased() }.map{$0.element}
                currentLine = endIndex + 1
                guard let repeatedStatements = convertToStatements(lines: repeatedLines) else { return nil }
                if let count = Int(repeatCount){
                    statements.append(Repeat(statements: repeatedStatements, value: Constant(count)))
                } else {
                    statements.append(Repeat(statements: repeatedStatements, value: Variable(name: repeatCount)))
                }
            case assignment:
                currentLine += 1
                guard let name = lineComponents.first, let value = Int(lineComponents[2]) else { return nil }
                statements.append(Assignment(variable: Variable(name: name), value: value))
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
