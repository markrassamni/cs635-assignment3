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
    let turtle = Turtle()
    let context = Context()
    var caretakerVisitor: CaretakerVisitor!
    var distanceVisitor: DistanceVisitor!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //TODO: Test with repeat 1 times, repeat 0 times
        caretakerVisitor = CaretakerVisitor(turtle: turtle, context: context)
        distanceVisitor = DistanceVisitor(turtle: turtle, context: context)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testParsing(){
        // TODO: Make statements equatable
        let ast = fileParser.buildProgram(fromFile: "test1.txt")
        XCTAssertNotNil(ast)
        let expectedStatements: [Statement] = [PenDown(), Repeat(statements: [Move(distance: 10)!, Move(distance: 15)!, Move(distance: 20)!], repeatCount: 2), Move(distance: 10)!, Turn(degrees: 10), Move(distance: 10)!]
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
        ast!.accept(visitor: distanceVisitor)
        XCTAssertEqual(distanceVisitor.distance, 20)
    }
    
    func testCaretakerVisitor(){
        let ast = fileParser.buildProgram(fromFile: "test1.txt")
        XCTAssertNotNil(ast)
        ast!.accept(visitor: caretakerVisitor)
        let mementos = caretakerVisitor.mementos
        XCTAssertEqual(mementos.count, 11)
        let memento = Memento()
        memento.setState(name: turtle.locationState, value: Point(0,0))
        memento.setState(name: turtle.directionState, value: 0)
        memento.setState(name: turtle.penDownState, value: false)
        
        XCTAssertEqual(mementos[0], memento)
        memento.setState(name: turtle.penDownState, value: true)
        XCTAssertEqual(mementos[1], memento)
        memento.setState(name: turtle.locationState, value: Point(10,0))
        XCTAssertEqual(mementos[2], memento)
        memento.setState(name: turtle.locationState, value: Point(25,0))
        XCTAssertEqual(mementos[3], memento)
        memento.setState(name: turtle.locationState, value: Point(45,0))
        XCTAssertEqual(mementos[4], memento)
        memento.setState(name: turtle.locationState, value: Point(55,0))
        XCTAssertEqual(mementos[5], memento)
        memento.setState(name: turtle.locationState, value: Point(70,0))
        XCTAssertEqual(mementos[6], memento)
        memento.setState(name: turtle.locationState, value: Point(90,0))
        XCTAssertEqual(mementos[7], memento)
        memento.setState(name: turtle.locationState, value: Point(100,0))
        XCTAssertEqual(mementos[8], memento)
        memento.setState(name: turtle.directionState, value: 10)
        XCTAssertEqual(mementos[9], memento)
        memento.setState(name: turtle.locationState, value: Point(109.84808,  1.73648))
        XCTAssertEqual(mementos[10], memento)
        
        
        
//        XCTAssertEqual(mementos[0], Memento(direction: 0, location: Point(0,0), isPenDown: false))
//        XCTAssertEqual(mementos[1], Memento(direction: 0, location: Point(0,0), isPenDown: true))
//        XCTAssertEqual(mementos[2], Memento(direction: 0, location: Point(10,0), isPenDown: true))
//        XCTAssertEqual(mementos[3], Memento(direction: 0, location: Point(25,0), isPenDown: true))
//        XCTAssertEqual(mementos[4], Memento(direction: 0, location: Point(45,0), isPenDown: true))
//        XCTAssertEqual(mementos[5], Memento(direction: 0, location: Point(55,0), isPenDown: true))
//        XCTAssertEqual(mementos[6], Memento(direction: 0, location: Point(70,0), isPenDown: true))
//        XCTAssertEqual(mementos[7], Memento(direction: 0, location: Point(90,0), isPenDown: true))
//        XCTAssertEqual(mementos[8], Memento(direction: 0, location: Point(100,0), isPenDown: true))
//        XCTAssertEqual(mementos[9], Memento(direction: 10, location: Point(100,0), isPenDown: true))
//        XCTAssertEqual(mementos[10], Memento(direction: 10, location: Point(109.84808,  1.73648), isPenDown: true))
    }
    
    /*
    func testCaretakerVisitorWithVariable(){
        let ast = fileParser.buildProgram(fromFile: "test3.txt")
        XCTAssertNotNil(ast)
        ast!.accept(visitor: caretakerVisitor)
        let mementos = caretakerVisitor.mementos
        XCTAssertEqual(mementos.count, 9)
        XCTAssertEqual(mementos[0], Memento(direction: 0, location: Point(0,0), isPenDown: false))
        XCTAssertEqual(mementos[1], Memento(direction: 0, location: Point(0,0), isPenDown: true))
        XCTAssertEqual(mementos[2], Memento(direction: 0, location: Point(15,0), isPenDown: true))
        XCTAssertEqual(mementos[3], Memento(direction: 90, location: Point(15,0), isPenDown: true))
        XCTAssertEqual(mementos[4], Memento(direction: 90, location: Point(15,15), isPenDown: true))
        XCTAssertEqual(mementos[5], Memento(direction: 180, location: Point(15,15), isPenDown: true))
        XCTAssertEqual(mementos[6], Memento(direction: 180, location: Point(0,15), isPenDown: true))
        XCTAssertEqual(mementos[7], Memento(direction: 270, location: Point(0,15), isPenDown: true))
        XCTAssertEqual(mementos[8], Memento(direction: 270, location: Point(0,0), isPenDown: true))
    }
 */
}
