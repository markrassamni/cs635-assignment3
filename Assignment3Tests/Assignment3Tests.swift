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
        let statements = fileParser.parse(file: "test1.txt")
        XCTAssertNotNil(statements)
        let expectedStatements: [Statement] = [Repeat(statements: [Move(distance: 10), Move(distance: 15), Move(distance: 20)], repeatCount: 2), Move(distance: 10), Turn(degrees: 10), Move(distance: 10)]
//        XCTAssertEqual(statements!, expectedStatements)
        //        XCTAssertEqual(statements!, expectedStatements)
//        XCTAssertEqual(statements!, expectedStatements)
        /*
         Repeat 2
         move 10
         mOve 15
         move 20
         end
         move 10
         turn 10
         move 10
         
        */
    }
    
    /*
    func testParsing(){
        guard let fileParser = FileParser(file: "test1.txt") else {
            XCTAssertTrue(false)
            return
        }
        for _ in 0..<fileParser.lines.count {
            let expression = fileParser.parseNextCommand()
            print(expression ?? "Not returned")
        }
        
    }
     */

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
