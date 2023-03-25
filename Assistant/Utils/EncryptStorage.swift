//
//  Storage.swift
//  MybkMobile
//
//  Created by DucTran on 17/03/2023.
//

import Foundation
import UIKit
import CryptoSwift

extension String {
    func toFixedUInt8Array() -> [UInt8] {
        let fixedSize = 16
        let paddedString = self.padding(toLength: fixedSize, withPad: " ", startingAt: 0)
        guard let utf8 = paddedString.data(using: .utf8) else {
            fatalError("Failed to convert string to data")
        }
        var result = [UInt8](repeating: 0, count: fixedSize)
        utf8.copyBytes(to: &result, count: min(fixedSize, utf8.count))
        return result
    }
}

final class EncriptStorageKey {
    
    static func updateStorage(with key: String, value: String) -> Bool {
        do {
            let keyString = String(decoding: UUID().uuidString.toFixedUInt8Array(), as: UTF8.self)
            let ivString = String(decoding: UIDevice.current.identifierForVendor!.uuidString.toFixedUInt8Array(), as: UTF8.self)
            let aes = try AES(key: keyString,
                              iv: ivString )
            let encryptedData = try aes.encrypt(value.bytes)
            UserDefaults.standard.setValue(Data(encryptedData), forKey: key)
            return true
        } catch {
            return false
        }
    }
    
    static func clearStorage(with key: String) -> Bool {
        UserDefaults.standard.removeObject(forKey: key)
        return true
    }
    
    static func getStorage (with key: String) -> String? {
        guard let encryptedData = UserDefaults.standard.data(forKey: key) else { return nil }
        do {
            let keyString = String(decoding: UUID().uuidString.toFixedUInt8Array(), as: UTF8.self)
            let ivString = String(decoding: UIDevice.current.identifierForVendor!.uuidString.toFixedUInt8Array(), as: UTF8.self)
            let aes = try AES(key: keyString,
                              iv: ivString )
            let decryptedBytes = try aes.decrypt(encryptedData.bytes)
            return String(decoding: decryptedBytes, as: UTF8.self)
        } catch {
            return nil
        }
    }
    
}
