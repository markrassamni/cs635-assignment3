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
        // TODO: Add visitors to all testing where possible
        fileParser = FileParser()
        turtle = Turtle()
        context = Context()
        caretakerVisitor = CaretakerVisitor(turtle: Turtle(), context: context)
        distanceVisitor = DistanceVisitor(turtle: Turtle(), context: context)
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
    
    func testRepeatWithoutBody(){
        let ast = fileParser.buildProgram(fromFile: "repeatNoBody.txt")
        XCTAssertNotNil(ast)
        ast!.interpret()
        XCTAssertEqual(ast!.turtle.location().x, 50)
        XCTAssertEqual(ast!.turtle.location().y, 0)
        ast!.accept(visitor: caretakerVisitor)
        let mementoLocation = caretakerVisitor.mementos.last!.getState(name: turtle.locationState) as! Point
        XCTAssertEqual(mementoLocation.x, 50)
        XCTAssertEqual(mementoLocation.y, 0)
        ast!.accept(visitor: distanceVisitor)
        XCTAssertEqual(distanceVisitor.distance, 50)
    }
    
    func testReassignVarInUnexecutedRepeat(){
        let ast = fileParser.buildProgram(fromFile: "reassignInRepeat0.txt")
        XCTAssertNotNil(ast)
        ast!.interpret()
        XCTAssertEqual(ast!.turtle.location().x, 20)
        XCTAssertEqual(ast!.turtle.location().y, 0)
        ast!.accept(visitor: distanceVisitor)
        XCTAssertEqual(distanceVisitor.distance, 20)
        ast!.accept(visitor: caretakerVisitor)
        let mementoLocation = caretakerVisitor.mementos.last!.getState(name: turtle.locationState) as! Point
        XCTAssertEqual(mementoLocation.x, 20)
        XCTAssertEqual(mementoLocation.y, 0)
    }
    
    func testNestedRepeat(){
        let ast = fileParser.buildProgram(fromFile: "nestedRepeat.txt")
        XCTAssertNotNil(ast)
        ast!.interpret()
        XCTAssertEqual(ast!.turtle.location().x, 20, accuracy: 0.0001)
        XCTAssertEqual(ast!.turtle.location().y, 0, accuracy: 0.0001)
        XCTAssertEqual(ast!.turtle.direction(), 270)
        XCTAssertEqual(ast!.turtle.isPenDown, true)
        ast?.accept(visitor: distanceVisitor)
        XCTAssertEqual(distanceVisitor.distance, 40)
        ast?.accept(visitor: caretakerVisitor)
        let lastState = caretakerVisitor.mementos.last!
        XCTAssertEqual(lastState.getState(name: turtle.directionState) as! Int, 270)
        XCTAssertEqual((lastState.getState(name: turtle.locationState) as! Point).x, 20)
        XCTAssertEqual((lastState.getState(name: turtle.locationState) as! Point).y, 0)
        XCTAssertEqual(lastState.getState(name: turtle.penDownState) as! Bool, true)
    }
    
    func test6NestedRepeats(){
        let ast = fileParser.buildProgram(fromFile: "6nestedRepeats.txt")
        XCTAssertNotNil(ast)
        ast!.interpret()
        ast?.accept(visitor: distanceVisitor)
        XCTAssertEqual(distanceVisitor.distance, 90)
        XCTAssertEqual(ast!.turtle.direction(), 2160)
        XCTAssertEqual(ast!.turtle.location().x, 10, accuracy: 0.0001)
        XCTAssertEqual(ast!.turtle.location().y, 0, accuracy: 0.0001)
        XCTAssertEqual(ast!.turtle.isPenDown, true)
        ast?.accept(visitor: caretakerVisitor)
        let lastMemento = caretakerVisitor.mementos.last!
        XCTAssertEqual(ast!.turtle.location().x, (lastMemento.getState(name: turtle.locationState) as! Point).x)
        XCTAssertEqual(ast!.turtle.location().y, (lastMemento.getState(name: turtle.locationState) as! Point).y)
        XCTAssertEqual(ast!.turtle.direction(), lastMemento.getState(name: turtle.directionState) as! Int)
        XCTAssertEqual(ast!.turtle.isPenDown, lastMemento.getState(name: turtle.penDownState) as! Bool)
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
}
