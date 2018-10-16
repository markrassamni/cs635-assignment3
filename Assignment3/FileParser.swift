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
                // FIXME: Bug when nesting repeats, getting first "end" gets end for 2nd repeat not for first
                guard lineComponents.count == 2 else { return nil }
                let repeatCount = lineComponents[1]
                
                
                var endIndices = lines.enumerated().filter{ $0.element.lowercased().components(separatedBy: " ").filter {$0 != ""}.first == endRepeat.lowercased() && $0.offset > currentLine && $0.offset < lines.count}.map{$0.offset}
                let repeatIndices = lines.enumerated().filter{ $0.element.lowercased().components(separatedBy: " ").filter {$0 != ""}.first  == repeatCommand.lowercased() && $0.offset > currentLine && $0.offset < lines.count}.map { $0.offset }
                
                // TODO: this end index is wrong. Could have our end come first and all repeats after with their ends
                // Want to find first end that has no repeat before it
//                let endIndex = endIndices[repeatIndices.count]
                
                /*
                var endIndex: Int
                
                if repeatIndices.count == 0 || endIndices.count == 1 {
                    endIndex = endIndices[0]
                } else if let endFirst = endIndices.first, let repeatFirst = repeatIndices.first, endFirst < repeatFirst {
                    endIndex = endFirst
                } else if repeatIndices.count >= endIndices.count {
                    for (iteration, index) in endIndices.enumerated() {
                        if endIndices[iteration] < repeatIndices[iteration] {
                            endIndex = endIndices[iteration]
                        }
                    }
                }
                 */
                
                // End 7 15
                // Repeat 9
                // True end 7
                
                // End 13 17
                // Repeat 7
                // True end 17
                
                // Top = first, bottom = last
                
                // Look for next repeat or next end, if find repeat skip next end, if find end use it
                
                // For every repeat I find remove the next end after it in endIndices
                
                // Cant just find this repeats end because incrementing cvurrentLine to this end will skip inner repeats? - False - repeat recalls this func, should be ok.. ?
                
//                for (repeatIter, repeatIndex) in repeatIndices.enumerated() {
//                    for (endIter, endIndex) in endIndices.enumerated(){
//
//                    }
//                }
                
                // Current = 5
                // End = 7 12
                // Repeat = nil
                
                
                for repeatIndex in repeatIndices {
                    if let index = endIndices.index(where: { $0 > repeatIndex}) {
                        endIndices.remove(at: index)
                    }
                }
                guard let endIndex = endIndices.first else { return nil }
                
                
                
                
                
                
                // Need first end with no repeat in between current and end
                
                
//                if endIndices.count <= repeatIndices.count {
//                    endIndex = endIndices.enumerated().filter { $0.element < repeatIndices[$0.offset] }.map {$0.element}[0]
//                } else {
//                    endIndex = repeatIndices.enumerated().filter { $0.element > endIndices[$0.offset] }.map {endIndices[$0.offset]}[0]
//                }
                
                // ends at 7 15
                // repeat at 9
                // want end at 7
                
                // ends at 13 17
                // repeat at 7
                // want end at 17
                
                
                
                
//                let optionalEndIndex = lines.enumerated().filter{ $0.element.lowercased() == endRepeat.lowercased() && $0.offset > currentLine && $0.offset < lines.count}.map{$0.offset}.first
//                guard let endIndex = optionalEndIndex else { return nil }
                
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
