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
        let statements = fileParser.parse(file: "test1.txt")
        XCTAssertNotNil(statements)
        let expectedStatements: [Statement] = [Repeat(statements: [Move(distance: 10), Move(distance: 15), Move(distance: 20)], repeatCount: 2), Move(distance: 10), Turn(degrees: 10), Move(distance: 10)]
        /*
        XCTAssertEqual(statements?.count, expectedStatements.count)
        for (index, statement) in expectedStatements.enumerated() {
            XCTAssertEqual(statement, statements![index])
        }
         */
    }

}
