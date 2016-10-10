//
//  UInt8+Data.swift
//  Writer
//
//  Created by naru on 2016/09/12.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

internal extension UInt8 {
    
    init(data: Data) {
        var value: UInt8 = 0
        (data as NSData).getBytes(&value, length: MemoryLayout<UInt8>.size)
        self = value
    }
}
