//
//  promiseTests.swift
//  promiseTests
//
//  Created by XUWEI LIANG on 25/8/19.
//  Copyright © 2019 Wisetree Solutions. All rights reserved.
//

import XCTest
@testable import promise

class callbackTests: XCTestCase {

    // closure version
    func testClosureNesting() {
        let expectation = XCTestExpectation(description: "success is expected")
        sharedService.async_step1(random: false) { _ in
            sharedService.async_step2(random: false) { _ in
                sharedService.async_step3(random: false) { result in
                    switch result {
                    case .success(let data):
                        XCTAssertNotNil(data)
                        XCTAssertTrue(data)
                        expectation.fulfill()
                    case .failure:
                        XCTFail()
                        expectation.fulfill()
                    }
                }
            }
        }
    }

    func testClosureNestingWithErr() {
        let expectation = XCTestExpectation(description: "err is expected")
        sharedService.async_step1(random: false) { _ in
            sharedService.async_step2(random: false) { _ in
                sharedService.async_stepWithError { result in

                    switch result {
                    case .success:
                        XCTFail()
                        expectation.fulfill()
                        /// if we have error, we won't continue into the nested closures
                        sharedService.async_step3(random: false) { result in
                        }
                    case .failure(let err):
                        XCTAssertNotNil(err)
                        print(err.localizedDescription)
                        expectation.fulfill()
                    }


                }
            }
        }
    }

    // demo of callback hell
    func testClosureNestingWithRandomChanceOfError() {
        let expectation = XCTestExpectation(description: "err is expected")
        sharedService.async_step1(random: true) { result in

            switch result {
            case .success:
                /// if we have error, we won't continue into the nested closures
                sharedService.async_step2(random: true) { result2 in
                    switch result2 {
                    case .success:
                        sharedService.async_step3(random: true) { result3 in
                            switch result3 {
                            case .success(let data):
                                XCTAssertNotNil(data)
                                XCTAssertTrue(data)
                                print("success!")
                                expectation.fulfill()
                            case .failure(let err3):
                                XCTAssertNotNil(err3)
                                print("error: \(err3.localizedDescription)")
                                expectation.fulfill()
                            }
                        }
                    case .failure(let err2):
                        XCTAssertNotNil(err2)
                        print("error: \(err2.localizedDescription)")
                        expectation.fulfill()
                    }
                }
            case .failure(let err):
                XCTAssertNotNil(err)
                print("error: \(err.localizedDescription)")
                expectation.fulfill()
            }
        }
    }
}
