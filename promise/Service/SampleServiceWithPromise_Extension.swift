//
//  SampleServiceWithPromise_Extension.swift
//  promise
//
//  Created by XUWEI LIANG on 27/8/19.
//  Copyright © 2019 Wisetree Solutions. All rights reserved.
//

import Foundation
import PromiseKit

//MARK: for advanced demo
extension SampleServiceWithPromise {

    func async_step1_adv(randomResult: Bool, randomDelay: Bool)-> Promise<Bool> {
        print("async_step1")
        return Promise<Bool>() { resolver in
            let delay = randomDelay ? RandomUtil.randomDelay() : 0
            DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + .seconds(delay)) {
                print("async_step1 completed")
                if randomResult {
                    RandomUtil.randomBool() ? resolver.fulfill(RandomUtil.randomBool()) : resolver.reject(Step1Errors.randomElement() ?? Step1Error.unknown)
                } else {
                    resolver.fulfill(true)
                }
            }
        }
    }

    func async_step2_adv(randomResult: Bool, randomDelay: Bool)-> Promise<Bool>  {
        print("async_step2")
        return Promise<Bool>() { resolver in
            let delay = randomDelay ? RandomUtil.randomDelay() : 0
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .seconds(delay)) {
                print("async_step2 completed")
                if randomResult {
                    RandomUtil.randomBool() ? resolver.fulfill(RandomUtil.randomBool()) : resolver.reject(Step2Errors.randomElement() ?? Step2Error.unknown)
                } else {
                    resolver.fulfill(true)
                }
            }
        }
    }

    func async_step3_adv(randomResult: Bool, randomDelay: Bool)-> Promise<Bool>  {
        print("async_step3")

        return Promise<Bool>() { resolver in
            let delay = randomDelay ? RandomUtil.randomDelay() : 0
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .seconds(delay)) {
                print("async_step3 completed")
                if randomResult {
                    RandomUtil.randomBool() ? resolver.fulfill(RandomUtil.randomBool()) : resolver.reject(Step3Errors.randomElement() ?? Step3Error.unknown)
                } else {
                    resolver.fulfill(true)
                }
            }
        }
    }

    func async_stepWithError_adv()-> Promise<Bool>  {
        return Promise<Bool>() { resolver in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .seconds(RandomUtil.randomDelay())) {
                print("async_error")
                resolver.reject(GenericError.genericError)
            }
        }
    }
}
