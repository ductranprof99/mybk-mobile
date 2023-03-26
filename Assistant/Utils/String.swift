//
//  String.swift
//  MybkMobile
//
//  Created by DucTran on 17/03/2023.
//

import Foundation
import UIKit
import CryptoSwift

extension String {
    func toFixedUInt8Array(size fixedSize: Int = 16) -> [UInt8] {
        let paddedString = self.padding(toLength: fixedSize, withPad: " ", startingAt: 0)
        guard let utf8 = paddedString.data(using: .utf8) else {
            fatalError("Failed to convert string to data")
        }
        var result = [UInt8](repeating: 0, count: fixedSize)
        utf8.copyBytes(to: &result, count: min(fixedSize, utf8.count))
        return result
    }
    
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
