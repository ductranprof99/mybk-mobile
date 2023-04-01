//
//  Data.swift
//  MybkMobile
//
//  Created by DucTran on 01/04/2023.
//

import Foundation


extension Data {
    public func toHTMLString() -> String? {
        if let attributedString = try? NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            return attributedString.string
        }
        return nil
    }
}
