//
//  HTMLutils.swift
//  MybkMobile
//
//  Created by DucTran on 17/03/2023.
//

import Foundation
import SwiftSoup

final class HTMLutils {
    static public func getValueOf(of str: String,
                                  element: String?,
                                  attribute: [String: String]? ) -> String? {
        do {
            let doc: Document = try SwiftSoup.parse(str)
            var xpath = ""
            xpath += element ?? ""
            if let attribute = attribute {
                xpath += "["
                for (key, value) in attribute {
                    xpath += "\(key)$='\(value)'"
                }
                xpath += "]"
            }
            guard let ele: Element = try doc.select(xpath).first() else {
                return nil
            }
            return try ele.val()
        } catch {
            print("cannot find element")
        }
        return nil
    }
    
    static public func getValueWithClass(of str: String, element: String?, class className: String) -> String? {
        do {
            let doc: Document = try SwiftSoup.parse(str)
            var xpath = ""
            xpath += element ?? ""
            xpath += "[class$='\(className)']"
            guard let ele: Element = try doc.select(xpath).first() else {
                return nil
            }
            return try ele.val()
        } catch {
            print("cannot find element")
        }
        return nil
    }
    
    static public func getValueWithFullXpath(of str: String, xpath: String) -> String? {
        do {
            let doc: Document = try SwiftSoup.parse(str)
            guard let ele: Element = try doc.select(xpath).first() else {
                return nil
            }
            return try ele.val()
        } catch {
            print("cannot find element")
        }
        return nil
    }
    
    static public func getContentWithFullXpath(of str: String, xpath: String) -> String? {
        do {
            let doc: Document = try SwiftSoup.parse(str)
            guard let ele: Element = try doc.select(xpath).first() else {
                return nil
            }
            return try ele.text()
        } catch {
            print(error.localizedDescription)
            print("cannot find element")
        }
        return nil
    }
    
    static public func getHeaderMetaContent(of str: String, attribute: [String: String]?) -> String? {
        do {
            let doc: Document = try SwiftSoup.parse(str)
            var xpath = "meta"
            if let attribute = attribute {
                xpath += "["
                for (key, value) in attribute {
                    xpath += "\(key)$='\(value)'"
                }
                xpath += "]"
            }
            let meta: Element? = try doc.head()?.select(xpath).first()
            let text: String? = try meta?.attr("content")
            return text
        } catch {
            return nil
        }
    }
}
