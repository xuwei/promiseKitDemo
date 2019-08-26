//
//  groupTests.swift
//  promiseTests
//
//  Created by XUWEI LIANG on 25/8/19.
//  Copyright © 2019 Wisetree Solutions. All rights reserved.
//

import XCTest
import PromiseKit
@testable import promise

// Testing waiting for a group api calls to finish
class groupTests: XCTestCase {

    // using "when resolved" which doesn't catch errors, this is only useful for callbacks with no error handling
    func testGroup1() {
        let expectation = XCTestExpectation(description: "all calls should finished")

        let a = sharedServiceWithPromise.async_step1_adv(randomResult: false, randomDelay: false)
        let b = sharedServiceWithPromise.async_step2_adv(randomResult: false, randomDelay: false)
        let c = sharedServiceWithPromise.async_step3_adv(randomResult: false, randomDelay: false)
        when(resolved: [a, b, c]).done { _ in
            print("all resolved!")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    // "when fulfilled" is more practical, but promise signature must be same
    // in this case, they are all Promise<Bool>
    func testGroup2() {
        let expectation = XCTestExpectation(description: "all calls should fulfill")
        let a = sharedServiceWithPromise.async_step1_adv(randomResult: false, randomDelay: true)
        let b = sharedServiceWithPromise.async_step2_adv(randomResult: false, randomDelay: true)
        let c = sharedServiceWithPromise.async_step3_adv(randomResult: false, randomDelay: true)

        when(fulfilled: [a, b, c]).done{ results in
            print("all fulfilled!")
            results.forEach { result in print(result) }
        }.catch{ _ in
            XCTFail()
        }.finally {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    // catching error amongst group
    func testGroup3() {
        let expectation = XCTestExpectation(description: "all calls should fulfill")
        let a = sharedServiceWithPromise.async_step1_adv(randomResult: false, randomDelay: true)
        let b = sharedServiceWithPromise.async_step2_adv(randomResult: false, randomDelay: true)
        let c = sharedServiceWithPromise.async_step3_adv(randomResult: false, randomDelay: true)
        let d = sharedServiceWithPromise.async_stepWithError_adv()
        when(fulfilled: [a, b, c, d]).done{ results in
            XCTFail()
        }.catch{ err in
            XCTAssertNotNil(err)
            print(err.localizedDescription)
        }.finally {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    // handling random conditions
    func testGroup4() {
        let expectation = XCTestExpectation(description: "all calls should fulfill")
        let a = sharedServiceWithPromise.async_step1_adv(randomResult: true, randomDelay: true)
        let b = sharedServiceWithPromise.async_step2_adv(randomResult: true, randomDelay: true)
        let c = sharedServiceWithPromise.async_step3_adv(randomResult: true, randomDelay: true)
        when(fulfilled: [a, b, c]).done{ result in
            print("all fulfilled!")
        }.catch{ err in
            XCTAssertNotNil(err)
            print("error: \(err.localizedDescription)")
        }.finally {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    // handling diff Promise signatures
    func testGroup5() {
        let expectation = XCTestExpectation(description: "all calls should fulfill")
        let a = sharedServiceWithPromise.async_step1_adv(randomResult: false, randomDelay: true)
        let b = sharedServiceWithPromise.async_step4(true)
        when(fulfilled: [a.asVoid(), b.asVoid()]).done{ result in
            print("all fulfilled!")
            print(a.value ?? false)
            print(b.value ?? 0)
        }.catch{ err in
            XCTFail()
        }.finally {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    // handling diff Promise signatures and has error
    func testGroup6() {
        let expectation = XCTestExpectation(description: "all calls should fulfill")
        let a = sharedServiceWithPromise.async_step1_adv(randomResult: false, randomDelay: true)
        let b = sharedServiceWithPromise.async_step4(true)
        let c = sharedServiceWithPromise.async_stepWithError_adv()
        when(fulfilled: [a.asVoid(), b.asVoid(), c.asVoid()]).done{ result in
            XCTFail()
        }.catch{ err in
            XCTAssertNotNil(err)
            print("error: \(err.localizedDescription)")
        }.finally {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
