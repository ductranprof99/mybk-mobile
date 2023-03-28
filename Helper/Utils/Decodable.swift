//
//  Decodable.swift
//  MybkMobile
//
//  Created by DucTran on 28/03/2023.
//

import Foundation

enum DictionaryParsingError: Error {
    case jsonSerialization(Error)
    case decode(Error)
}
extension Decodable {
    init<Key: Hashable>(_ dict: [Key: Any]) throws
    {
        let data = try JSONSerialization.data(withJSONObject: dict, options: [])
        self = try JSONDecoder().decode(Self.self, from: data)
    }
    
    static func from<Key>(dictionary: [Key: Any],
                          options: JSONSerialization.WritingOptions = [],
                          decoder: JSONDecoder) -> Result<Self, DictionaryParsingError> where Key: Hashable {
        let data: Data
        do {
            data = try JSONSerialization.data(withJSONObject: dictionary, options: options)
        } catch let error {
            return .failure(.jsonSerialization(error))
        }

        do {
            return .success(try decoder.decode(Self.self, from: data))
        } catch let error {
            return .failure(.decode(error))
        }
    }

    static func from<Key>(dictionary: [Key: Any],
                          options: JSONSerialization.WritingOptions = [],
                          singleUseDecoder configuration: (JSONDecoder) -> ()) -> Result<Self, DictionaryParsingError> where Key: Hashable {
        let decoder = JSONDecoder()
        configuration(decoder)
        return from(dictionary: dictionary, options: options, decoder: decoder)
    }
}
