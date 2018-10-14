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
    
    func testTurtleMoveAndRotate(){
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
    }
    
    func testCaretakerVisitorWithVariable(){
        let ast = fileParser.buildProgram(fromFile: "test3.txt")
        XCTAssertNotNil(ast)
        ast!.accept(visitor: caretakerVisitor)
        let mementos = caretakerVisitor.mementos
        XCTAssertEqual(mementos.count, 9)
        let memento = Memento()
        memento.setState(name: turtle.locationState, value: Point(0,0))
        memento.setState(name: turtle.directionState, value: 0)
        memento.setState(name: turtle.penDownState, value: false)
        XCTAssertEqual(mementos[0], memento)
        memento.setState(name: turtle.penDownState, value: true)
        XCTAssertEqual(mementos[1], memento)
        memento.setState(name: turtle.locationState, value: Point(15,0))
        XCTAssertEqual(mementos[2], memento)
        memento.setState(name: turtle.directionState, value: 90)
        XCTAssertEqual(mementos[3], memento)
        memento.setState(name: turtle.locationState, value: Point(15,15))
        XCTAssertEqual(mementos[4], memento)
        memento.setState(name: turtle.directionState, value: 180)
        XCTAssertEqual(mementos[5], memento)
        memento.setState(name: turtle.locationState, value: Point(0,15))
        XCTAssertEqual(mementos[6], memento)
        memento.setState(name: turtle.directionState, value: 270)
        XCTAssertEqual(mementos[7], memento)
        memento.setState(name: turtle.locationState, value: Point(0,0))
        XCTAssertEqual(mementos[8], memento)
    }
}
