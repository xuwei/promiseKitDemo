//
//  Errors.swift
//  promise
//
//  Created by XUWEI LIANG on 27/8/19.
//  Copyright © 2019 Wisetree Solutions. All rights reserved.
//

import UIKit

let allErrors: [Error] = [Step1Error.step1Error1, Step1Error.step1Error2, Step1Error.step1Error3, Step2Error.step2Error1, Step2Error.step2Error2, Step3Error.step3Error1, Step3Error.step3Error2]

let Step1Errors: [Error] = [Step1Error.step1Error1, Step1Error.step1Error2, Step1Error.step1Error3]
let Step2Errors: [Error] = [Step2Error.step2Error1, Step2Error.step2Error2]
let Step3Errors: [Error] = [Step3Error.step3Error1, Step3Error.step3Error2]

enum Step1Error: Error {
    case step1Error1
    case step1Error2
    case step1Error3
    case unknown
}

enum Step2Error: Error {
    case step2Error1
    case step2Error2
    case unknown
}

enum Step3Error: Error {
    case step3Error1
    case step3Error2
    case unknown
}

enum GenericError: Error {
    case genericError
}

extension Step1Error: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .step1Error1:
            return NSLocalizedString("step 1 error 1", comment: "")
        case .step1Error2:
            return NSLocalizedString("step 1 error 2", comment: "")
        case .step1Error3:
            return NSLocalizedString("step 1 error 3", comment: "")
        case .unknown:
            return NSLocalizedString("step 1 unknown error", comment: "")
        }
    }
}

extension Step2Error: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .step2Error1:
            return NSLocalizedString("step 2 error 1", comment: "")
        case .step2Error2:
            return NSLocalizedString("step 2 error 2", comment: "")
        case .unknown:
            return NSLocalizedString("step 2 unknown error", comment: "")
        }
    }
}

extension Step3Error: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .step3Error1:
            return NSLocalizedString("step 3 error 1", comment: "")
        case .step3Error2:
            return NSLocalizedString("step 3 error 2", comment: "")
        case .unknown:
            return NSLocalizedString("step 3 unknown error", comment: "")
        }
    }
}

extension GenericError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .genericError:
            return NSLocalizedString("generic error", comment: "")
        }
    }
}



