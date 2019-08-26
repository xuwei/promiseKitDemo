//
//  Util.swift
//  promise
//
//  Created by XUWEI LIANG on 26/8/19.
//  Copyright © 2019 Wisetree Solutions. All rights reserved.
//

import UIKit

class Util {
    class func randomBool()-> Bool {
        return [true,false].randomElement() ?? true
    }

    class func randomDelay()->Int {
        return Int.random(in: 1..<5)
    }
}
