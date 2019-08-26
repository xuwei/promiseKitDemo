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
        return Promise<Bool>() { resolver in
            if random {
                Util.randomBool() ? resolver.fulfill(true) : resolver.reject(Step1Errors.randomElement() ?? Step1Error.unknown)
            } else {
                resolver.fulfill(true)
            }
        }
    }

    func async_step2(random: Bool)-> Promise<Bool>  {
        print("async_step2")
        return Promise<Bool>() { resolver in
            if random {
                Util.randomBool() ? resolver.fulfill(true) : resolver.reject(Step2Errors.randomElement() ?? Step2Error.unknown)
            } else {
                resolver.fulfill(true)
            }
        }
    }

    func async_step3(random: Bool)-> Promise<Bool>  {
        print("async_step3")
        return Promise<Bool>() { resolver in
            if random {
                Util.randomBool() ? resolver.fulfill(true) : resolver.reject(Step3Errors.randomElement() ?? Step3Error.unknown)
            } else {
                resolver.fulfill(true)
            }
        }
    }

    func async_stepWithError()-> Promise<Bool>  {
        return Promise<Bool>() { resolver in
            print("async_error")
            resolver.reject(GenericError.genericError)
        }
    }

    // taking data as parameter for demo purpose of data transformation
    func async_step4(_ data: Bool)-> Promise<Int> {
        return Promise<Int>() { resolver in
            resolver.fulfill(100)
        }
    }
}

//MARK: for advanced demo
extension SampleServiceWithPromise {

    func async_step1_adv(randomResult: Bool, randomDelay: Bool)-> Promise<Bool> {
        print("async_step1")
        return Promise<Bool>() { resolver in
            let delay = randomDelay ? Util.randomDelay() : 0
            DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + .seconds(delay)) {
                print("async_step1 completed")
                if randomResult {
                    Util.randomBool() ? resolver.fulfill(true) : resolver.reject(Step1Errors.randomElement() ?? Step1Error.unknown)
                } else {
                    resolver.fulfill(true)
                }
            }
        }
    }

    func async_step2_adv(randomResult: Bool, randomDelay: Bool)-> Promise<Bool>  {
        print("async_step2")
        return Promise<Bool>() { resolver in
            let delay = randomDelay ? Util.randomDelay() : 0
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .seconds(delay)) {
                print("async_step2 completed")
                if randomResult {
                    Util.randomBool() ? resolver.fulfill(true) : resolver.reject(Step2Errors.randomElement() ?? Step2Error.unknown)
                } else {
                    resolver.fulfill(true)
                }
            }
        }
    }

    func async_step3_adv(randomResult: Bool, randomDelay: Bool)-> Promise<Bool>  {
        print("async_step3")

        return Promise<Bool>() { resolver in
            let delay = randomDelay ? Util.randomDelay() : 0
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .seconds(delay)) {
                print("async_step3 completed")
                if randomResult {
                    Util.randomBool() ? resolver.fulfill(true) : resolver.reject(Step3Errors.randomElement() ?? Step3Error.unknown)
                } else {
                    resolver.fulfill(true)
                }
            }
        }
    }
}
