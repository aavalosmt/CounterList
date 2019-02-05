//
//  ArrayExtensionTests.swift
//  CounterListTests
//
//  Created by Aldo Antonio Martinez Avalos on 2/4/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import XCTest
@testable import CounterList

class ArrayExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddingIndicesInMiddle() {
        let oldArray: [Int] = [1,2,4,5,7,9]
        let newArray: [Int] = [1,2,3,4,5,6,7,8,9]
        
        let indices = newArray.addedIndices(oldArray: oldArray)
        XCTAssert(indices.count == 3)
    }
    
    func testDeletingIndicesInMiddle() {
        let newArray: [Int] = [1,2,4,5,7,9]
        let oldArray: [Int] = [1,2,3,4,5,6,7,8,9]
        
        let indices = oldArray.addedIndices(oldArray: newArray)
        XCTAssert(indices.count == 3)
    }
    
    func testDeletingIndicesAtEnd() {
        let newArray: [Int] = [1,2,3,4,5,6,7,8]
        let oldArray: [Int] = [1,2,3,4,5,6,7,8,9]
        
        let indices = oldArray.addedIndices(oldArray: newArray)
        XCTAssert(indices.first == 8)
    }
    
    func testAddingIndicesAtEnd() {
        let oldArray: [Int] = [1,2,3,4,5,6,7,8]
        let newArray: [Int] = [1,2,3,4,5,6,7,8,9]
        
        let indices = newArray.addedIndices(oldArray: oldArray)
        XCTAssert(indices.first == 8)
    }
    
    func testDeletingIndicesAtBeginning() {
        let oldArray: [Int] = [3,4,5,6,7,8,9]
        let newArray: [Int] = [1,2,3,4,5,6,7,8,9]
        let indices = newArray.addedIndices(oldArray: oldArray)
        XCTAssert(indices.first == 0 && indices.last == 1)
    }
    
}
