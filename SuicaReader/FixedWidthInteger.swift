//
//  FixedWidthInteger.swift
//  SuicaReader
//
//  Created by Yasuo Hasegawa on 2020/05/13.
//  Copyright © 2020 Yasuo Hasegawa. All rights reserved.
//

// https://developer.apple.com/documentation/swift/fixedwidthinteger
import Foundation
extension FixedWidthInteger {
    var binaryString: String {
        var result: [String] = []
        for i in 0..<(Self.bitWidth / 8) {
            let byte = UInt8(truncatingIfNeeded: self >> (i * 8))
            let byteString = String(byte, radix: 2)
            let padding = String(repeating: "0",
                                 count: 8 - byteString.count)
            result.append(padding + byteString)
        }
        return "0b" + result.reversed().joined(separator: "_")
    }
}
