//
//  String.swift
//  Pencil
//
//  Created by naru on 2016/10/13.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

extension String: ReadWriteElement {
    
    public var pencilDataLength: Int {
        return MemoryLayout<UInt8>.size + self.lengthOfBytes(using: String.Encoding.utf8)
    }
    
    public var pencilHead: [Data] {
        var count: UInt8 = UInt8(self.lengthOfBytes(using: String.Encoding.utf8))
        return [Data(buffer: UnsafeBufferPointer(start: &count, count: 1))]
    }
    
    public var pencilBody: [Data] {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return [Data()]
        }
        return [data]
    }
    
    public static var read: ((Components) -> String?) = { components in
        
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        
        let length: UInt8 = UInt8(data: data.subdata(in: 0..<MemoryLayout<UInt8>.size))
        let subdata = data.subdata(from: MemoryLayout<UInt8>.size, with: Int(length))
        return NSString(data: subdata, encoding: String.Encoding.utf8.rawValue) as? String
    }
}