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
    
    var fileParser: FileParser!
    var turtle: Turtle!
    var context: Context!
    var caretakerVisitor: CaretakerVisitor!
    var distanceVisitor: DistanceVisitor!

    override func setUp() {
        fileParser = FileParser()
        turtle = Turtle()
        context = Context()
        caretakerVisitor = CaretakerVisitor(turtle: turtle, context: context)
        distanceVisitor = DistanceVisitor(turtle: turtle, context: context)
        
    }

    override func tearDown() {
        fileParser = nil
        turtle = nil
        context = nil
        caretakerVisitor = nil
        distanceVisitor = nil
    }
    
    func testTurtleSquare(){
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
    
    func testProgram(){
        var ast = fileParser.buildProgram(fromFile: "test1.txt")
        XCTAssertNotNil(ast)
        ast!.interpret()
        XCTAssertEqual(ast!.turtle.location().x, 109.84808, accuracy: 0.0001)
        XCTAssertEqual(ast!.turtle.location().y, 1.73648, accuracy: 0.0001)
        XCTAssertEqual(ast!.turtle.direction(), 10)
        XCTAssertEqual(ast!.turtle.isPenDown, true)
        ast = fileParser.buildProgram(fromFile: "test2.txt")
        XCTAssertNotNil(ast)
        ast!.interpret()
        XCTAssertEqual(ast!.turtle.location().x, 0, accuracy: 0.0001)
        XCTAssertEqual(ast!.turtle.location().y, 0, accuracy: 0.0001)
        XCTAssertEqual(ast!.turtle.direction(), 180)
        XCTAssertEqual(ast!.turtle.isPenDown, true)
        ast = fileParser.buildProgram(fromFile: "test3.txt")
        XCTAssertNotNil(ast)
        ast!.interpret()
        XCTAssertEqual(ast!.turtle.location().x, 0, accuracy: 0.0001)
        XCTAssertEqual(ast!.turtle.location().y, 0, accuracy: 0.0001)
        XCTAssertEqual(ast!.turtle.direction(), 270)
        XCTAssertEqual(ast!.turtle.isPenDown, true)
        ast = fileParser.buildProgram(fromFile: "test4.txt")
        XCTAssertNotNil(ast)
        ast!.interpret()
        XCTAssertEqual(ast!.turtle.location().x, 0, accuracy: 0.0001)
        XCTAssertEqual(ast!.turtle.location().y, 0, accuracy: 0.0001)
        XCTAssertEqual(ast!.turtle.direction(), 360)
        XCTAssertEqual(ast!.turtle.isPenDown, true)
    }
    
    func testRepeatNegativeAndZero(){
        let ast = fileParser.buildProgram(fromFile: "test5.txt")
        XCTAssertNotNil(ast)
        ast!.interpret()
        XCTAssertEqual(ast!.turtle.location().x, 5, accuracy: 0.0001)
        XCTAssertEqual(ast!.turtle.location().y, 0, accuracy: 0.0001)
        XCTAssertEqual(ast!.turtle.direction(), 0)
        XCTAssertEqual(ast!.turtle.isPenDown, true)
        ast?.accept(visitor: distanceVisitor)
        XCTAssertEqual(distanceVisitor.distance, 5)
    }
    
    func testNestedRepeat(){
        // TODO: Implement, also do with visitor?
    }
    
    func testReassignVariable(){
        let ast = fileParser.buildProgram(fromFile: "test6.txt")
        XCTAssertNotNil(ast)
        ast!.interpret()
        XCTAssertEqual(ast!.turtle.location().x, 50, accuracy: 0.0001)
        XCTAssertEqual(ast!.turtle.location().y, 0, accuracy: 0.0001)
        XCTAssertEqual(ast!.turtle.direction(), 0)
        XCTAssertEqual(ast!.turtle.isPenDown, true)
        ast?.accept(visitor: distanceVisitor)
        XCTAssertEqual(distanceVisitor.distance, 50)
        ast?.accept(visitor: caretakerVisitor)
        let memento = caretakerVisitor.mementos.last
        XCTAssertNotNil(memento)
        XCTAssertEqual(ast!.turtle, caretakerVisitor.turtle)
        guard let direction = memento?.getState(name: caretakerVisitor.turtle.directionState) as? Int, let location = memento?.getState(name: caretakerVisitor.turtle.locationState) as? Point, let isPenDown = memento?.getState(name: caretakerVisitor.turtle.penDownState) as? Bool else {
            XCTAssertTrue(false)
            return
        }
        XCTAssertEqual(direction, ast!.turtle.direction())
        XCTAssertEqual(location.x, ast!.turtle.location().x)
        XCTAssertEqual(location.y, ast!.turtle.location().y)
        XCTAssertEqual(isPenDown, ast!.turtle.isPenDown)
    }
    
    func testDistanceVisitor(){
        let ast = fileParser.buildProgram(fromFile: "test2.txt")
        XCTAssertNotNil(ast)
        ast!.accept(visitor: distanceVisitor)
        XCTAssertEqual(distanceVisitor.distance, 20)
    }
    
    func testDistanceVisitorRepeat(){
        let ast = fileParser.buildProgram(fromFile: "test4.txt")
        XCTAssertNotNil(ast)
        ast!.accept(visitor: distanceVisitor)
        XCTAssertEqual(distanceVisitor.distance, 40)
    }
    
    func testRestoreState(){
        testRestoreState(fileName: "test1.txt")
        testRestoreState(fileName: "test2.txt")
        testRestoreState(fileName: "test3.txt")
        testRestoreState(fileName: "test4.txt")
    }
    
    func testRestoreState(fileName: String){
        let ast = fileParser.buildProgram(fromFile: fileName)
        XCTAssertNotNil(ast)
        ast!.accept(visitor: caretakerVisitor)
        let randomIndex = Int(arc4random_uniform(UInt32(caretakerVisitor.mementos.count)))
        let memento = caretakerVisitor.mementos[randomIndex]
        ast!.turtle.restoreState(from: caretakerVisitor.mementos[randomIndex])
        let turtle = ast!.turtle
        guard let location = memento.getState(name: turtle.locationState) as? Point, let direction = memento.getState(name: turtle.directionState) as? Int, let isPenDown = memento.getState(name: turtle.penDownState) as? Bool else {
            XCTAssertTrue(false)
            return
        }
        XCTAssertEqual(turtle.currentLocation.x, location.x)
        XCTAssertEqual(turtle.currentLocation.y, location.y)
        XCTAssertEqual(turtle.currentDirection, direction)
        XCTAssertEqual(turtle.isPenDown, isPenDown)
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
    
    func testProgramLastStateMatchCaretaker(){
        // TODO: Test program.execute and visitor visit and compare last state to program
    }
}
