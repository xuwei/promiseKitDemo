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

    func testGroup3() {
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
}
