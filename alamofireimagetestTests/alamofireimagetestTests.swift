//
//  alamofireimagetestTests.swift
//  alamofireimagetestTests
//
//  Created by Alexandros Spyropoulos on 09/05/2016.
//  Copyright © 2016 Alexandros Spyropoulos. All rights reserved.
//

import XCTest
@testable import alamofireimagetest

class alamofireimagetestTests: XCTestCase {
    
    let repo = ImageRepository()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testItmustEventuallyReturnOffers() {
        
        let expectation = expectationWithDescription("It loads data from home")
        
        repo.find()
            .onSuccess { data in
                XCTAssert(data.count > 0)
                expectation.fulfill()
        }
            .onFailure { error in
                XCTFail("repo.find() Error")
                expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10, handler:nil)
    }
    
    
    func testItMustLoadAPhoto() {
        let expectation = expectationWithDescription("It loads a photo")
        
        repo.find()
            .onSuccess { data in
                guard data.count > 0 else {
                    XCTFail("No Data")
                    expectation.fulfill()
                    return
                }
                
                data[0].load().onSuccess { _ in
                    expectation.fulfill()
                }
            }
            .onFailure { error in
                XCTFail("repo.find() Error")
                expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10, handler:nil)

    }
}
