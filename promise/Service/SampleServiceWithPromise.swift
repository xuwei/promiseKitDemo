//
//  SampleServiceWithPromise.swift
//  promise
//
//  Created by XUWEI LIANG on 25/8/19.
//  Copyright © 2019 Wisetree Solutions. All rights reserved.
//

import Foundation
import PromiseKit

let sharedServiceWithPromise = SampleServiceWithPromise()
let decisions = [true, false]

struct SampleServiceWithPromise {

    func async_step1(random: Bool)-> Promise<Bool> {
        print("async_step1")
        return Promise<Bool>() { seal in

            let decision = decisions.randomElement() ?? true
            if random {
                decision ? seal.fulfill(true) : seal.reject(Step1Errors.randomElement() ?? Step1Error.unknown)
            } else {
                seal.fulfill(true)
            }
        }
    }

    func async_step2(random: Bool)-> Promise<Bool>  {
        print("async_step2")
        return Promise<Bool>() { seal in
            let decision = decisions.randomElement() ?? true
            if random {
                decision ? seal.fulfill(true) : seal.reject(Step2Errors.randomElement() ?? Step2Error.unknown)
            } else {
                seal.fulfill(true)
            }
        }
    }

    func async_step3(random: Bool)-> Promise<Bool>  {
        print("async_step3")
        return Promise<Bool>() { seal in
            let decision = decisions.randomElement() ?? true
            if random {
                decision ? seal.fulfill(true) : seal.reject(Step3Errors.randomElement() ?? Step3Error.unknown)
            } else {
                seal.fulfill(true)
            }
        }
    }

    func async_stepWithError()-> Promise<Bool>  {
        return Promise<Bool>() { seal in
            print("async_error")
            seal.reject(GenericError.genericError)
        }
    }

    func async_step4()-> Promise<Int> {
        return Promise<Int>() { seal in
            seal.fulfill(100)
        }
    }
}
