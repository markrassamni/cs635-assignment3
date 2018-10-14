//
//  Assignment3Tests.swift
//  Assignment3Tests
//
//  Created by Mark Rassamni on 10/1/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import XCTest
@testable import Assignment3

class Assignment3Tests: XCTestCase {
    
    let fileParser = FileParser()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //TODO: Test with repeat 1 times, repeat 0 times
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testParsing(){
        // TODO: Make statements equatable
        let ast = fileParser.buildProgram(fromFile: "test1.txt")
        XCTAssertNotNil(ast)
        let expectedStatements: [Statement] = [Repeat(statements: [Move(distance: 10)!, Move(distance: 15)!, Move(distance: 20)!], repeatCount: 2), Move(distance: 10)!, Turn(degrees: 10), Move(distance: 10)!]
        let expectedAST = Program()
        for statement in expectedStatements {
            expectedAST.add(statement: statement)
        }
        /*
        XCTAssertEqual(statements?.count, expectedStatements.count)
        for (index, statement) in expectedStatements.enumerated() {
            XCTAssertEqual(statement, statements![index])
        }
         */
    }
    
    func testTurtleSquare(){
        let turtle = Turtle()
        turtle.penDown()
        XCTAssertEqual(turtle.location().x, 0.0, accuracy: 0.001)
        XCTAssertEqual(turtle.location().y, 0.0, accuracy: 0.001)
        XCTAssertEqual(turtle.currentDirection, 0)
        turtle.move(distance: 10)
        turtle.turn(degrees: 90)
        XCTAssertEqual(turtle.location().x, 10.0, accuracy: 0.001)
        XCTAssertEqual(turtle.location().y, 0.0, accuracy: 0.001)
        XCTAssertEqual(turtle.currentDirection, 90)
        turtle.move(distance: 10)
        turtle.turn(degrees: 90)
        XCTAssertEqual(turtle.location().x, 10.0, accuracy: 0.001)
        XCTAssertEqual(turtle.location().y, 10.0, accuracy: 0.001)
        XCTAssertEqual(turtle.currentDirection, 180)
        turtle.move(distance: 10)
        turtle.turn(degrees: 90)
        XCTAssertEqual(turtle.location().x, 0.0, accuracy: 0.001)
        XCTAssertEqual(turtle.location().y, 10.0, accuracy: 0.001)
        XCTAssertEqual(turtle.currentDirection, 270)
        turtle.move(distance: 10)
        turtle.turn(degrees: 90)
        XCTAssertEqual(turtle.location().x, 0.0, accuracy: 0.001)
        XCTAssertEqual(turtle.location().y, 0.0, accuracy: 0.001)
        XCTAssertEqual(turtle.currentDirection, 360)
    }
    
    func testTurtle2(){
        let turtle = Turtle()
        turtle.penDown()
        XCTAssertEqual(turtle.location().x, 0.0, accuracy: 0.001)
        XCTAssertEqual(turtle.location().y, 0.0, accuracy: 0.001)
        XCTAssertEqual(turtle.currentDirection, 0)
        turtle.move(distance: 10)
        turtle.turn(degrees: 90)
        turtle.move(distance: 20)
        turtle.turn(degrees: -60)
        turtle.move(distance: 15)
        XCTAssertEqual(turtle.location().x, 22.99, accuracy: 0.001)
        XCTAssertEqual(turtle.location().y, 27.5, accuracy: 0.001)
        XCTAssertEqual(turtle.currentDirection, 30)
    }
    
    func testDistanceVisitor(){
        let ast = fileParser.buildProgram(fromFile: "test2.txt")
        XCTAssertNotNil(ast)
        let distanceVisitor = DistanceVisitor()
        ast!.accept(visitor: distanceVisitor)
        XCTAssertEqual(distanceVisitor.distance, 20)
    }

}
