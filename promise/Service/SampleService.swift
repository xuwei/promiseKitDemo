//
//  SampleServiceManager.swift
//  promise
//
//  Created by XUWEI LIANG on 25/8/19.
//  Copyright © 2019 Wisetree Solutions. All rights reserved.
//

import Foundation

let sharedService = SampleService()

struct SampleService {

    func async_step1 (random: Bool, complete: @escaping (Result<Bool, Error>)-> Void) {
        print("async_step1")
        if random {
            RandomUtil.randomBool() ? complete(.success(true)) : complete(.failure(Step1Errors.randomElement() ?? Step1Error.step1Error1))
        } else {
            complete(.success(true))
        }
    }

    func async_step2 (random: Bool, complete: @escaping (Result<Bool, Error>)-> Void) {
        print("async_step2")
        if random {
            RandomUtil.randomBool() ? complete(.success(true)) : complete(.failure(Step2Errors.randomElement() ?? Step2Error.step2Error1))
        } else {
            complete(.success(true))
        }
    }

    func async_step3 (random: Bool, complete: @escaping (Result<Bool, Error>)-> Void) {
        print("async_step3")
        if random {
            RandomUtil.randomBool() ? complete(.success(true)) : complete(.failure(Step3Errors.randomElement() ?? Step3Error.step3Error1))
        } else {
            complete(.success(true))
        }
    }

    func async_stepWithError (complete: @escaping (Result<Bool, Error>)-> Void) {
        print("async_error")
        complete(.failure(GenericError.genericError))
    }
}
