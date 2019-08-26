//
//  variationTests.swift
//  promiseTests
//
//  Created by XUWEI LIANG on 25/8/19.
//  Copyright © 2019 Wisetree Solutions. All rights reserved.
//

import XCTest
import PromiseKit
@testable import promise

// testing transition of promise 
class TranstionTests: XCTestCase {

    func testTransition1() {
        let expectation = XCTestExpectation(description: "testing transition of promise type")
        firstly {
            return sharedServiceWithPromise.async_step1(random: false)
        }.then { data->Promise<Int> in
            XCTAssertNotNil(data)
            XCTAssertTrue(data == true)
            return sharedServiceWithPromise.async_step4(data)
        }.done { data in
            XCTAssertNotNil(data)
            XCTAssertTrue(data == 100)
        }.catch { err in
            XCTFail()
        }.finally {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: TestConstants.timeout)
    }

    func testTransitio2() {

    }
}
