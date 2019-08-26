//
//  promiseTests.swift
//  promiseTests
//
//  Created by XUWEI LIANG on 25/8/19.
//  Copyright © 2019 Wisetree Solutions. All rights reserved.
//

import XCTest
import PromiseKit
@testable import promise

class PromiseTests: XCTestCase {

    // promise version
    func testPromiseChaining() {
        let expectation = XCTestExpectation(description: "success is expected")
        sharedServiceWithPromise.async_step1(random: false).then { _ in
            sharedServiceWithPromise.async_step2(random: false)
        }.then { _ in
            sharedServiceWithPromise.async_step3(random: false)
        }.done { data in
            XCTAssertNotNil(data)
            XCTAssertTrue(data)
        }.catch {_ in
            XCTFail()
        }.finally {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: TestConstants.timeout)
    }

    func testPromiseWithErr() {
        let expectation = XCTestExpectation(description: "err is expected")
        sharedServiceWithPromise.async_step1(random: false)
        .then { _ in
            sharedServiceWithPromise.async_step2(random: false)
        }.then { _ in
            sharedServiceWithPromise.async_stepWithError()
        }.then { _ in
            sharedServiceWithPromise.async_step3(random: false)
        }.done { _ in
            XCTFail()
        }.catch { err in
            XCTAssertNotNil(err)
            print(err.localizedDescription)
        }.finally {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: TestConstants.timeout)
    }

    // promise to tackle callback hell challenge
    func testPromiseWithRandomChanceOfError() {
        let expectation = XCTestExpectation(description: "err is expected")
        sharedServiceWithPromise.async_step1(random: true)
            .then { _ in
                sharedServiceWithPromise.async_step2(random: true)
            }.then { _ in
                sharedServiceWithPromise.async_step3(random: true)
            }.ensure {
                print("finished all calls")
            }.done { data in
                XCTAssertNotNil(data)
                XCTAssertTrue(data)
                print("success!")
            }.catch { err in
                XCTAssertNotNil(err)
                print(err.localizedDescription)
            }.finally {
                expectation.fulfill()
        }
        wait(for: [expectation], timeout: TestConstants.timeout)
    }
}
