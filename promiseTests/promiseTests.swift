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

class promiseTests: XCTestCase {

//    // closure version
//    func testClosureNesting() {
//        let expectation = XCTestExpectation(description: "success is expected")
//        sharedService.async_step1(random: false) { _ in
//            sharedService.async_step2(random: false) { _ in
//                sharedService.async_step3(random: false) { result in
//                    switch result {
//                    case .success(let data):
//                        XCTAssertNotNil(data)
//                        XCTAssertTrue(data)
//                        expectation.fulfill()
//                    case .failure:
//                        XCTFail()
//                        expectation.fulfill()
//                    }
//                }
//            }
//        }
//    }

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
        wait(for: [expectation], timeout: 10.0)
    }

//    func testClosureNestingWithErr() {
//        let expectation = XCTestExpectation(description: "err is expected")
//        sharedService.async_step1(random: false) { _ in
//            sharedService.async_step2(random: false) { _ in
//                sharedService.async_stepWithError { result in
//
//                    switch result {
//                    case .success:
//                        XCTFail()
//                        expectation.fulfill()
//                        /// if we have error, we won't continue into the nested closures
//                        sharedService.async_step3(random: false) { result in
//                        }
//                    case .failure(let err):
//                        XCTAssertNotNil(err)
//                        print(err.localizedDescription)
//                        expectation.fulfill()
//                    }
//
//
//                }
//            }
//        }
//    }
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
        wait(for: [expectation], timeout: 10.0)
    }


    // demo of callback hell
//    func testClosureNestingWithRandomChanceOfError() {
//        let expectation = XCTestExpectation(description: "err is expected")
//        sharedService.async_step1(random: true) { result in
//
//            switch result {
//            case .success:
//                /// if we have error, we won't continue into the nested closures
//                sharedService.async_step2(random: true) { result2 in
//                    switch result2 {
//                    case .success:
//                        sharedService.async_step3(random: true) { result3 in
//                            switch result3 {
//                            case .success(let data):
//                                XCTAssertNotNil(data)
//                                XCTAssertTrue(data)
//                                print("success!")
//                                expectation.fulfill()
//                            case .failure(let err3):
//                                XCTAssertNotNil(err3)
//                                print("error: \(err3.localizedDescription)")
//                                expectation.fulfill()
//                            }
//                        }
//                    case .failure(let err2):
//                        XCTAssertNotNil(err2)
//                        print("error: \(err2.localizedDescription)")
//                        expectation.fulfill()
//                    }
//                }
//            case .failure(let err):
//                XCTAssertNotNil(err)
//                print("error: \(err.localizedDescription)")
//                expectation.fulfill()
//            }
//        }
//    }

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
        wait(for: [expectation], timeout: 10.0)
    }
}
