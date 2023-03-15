//
//  NetworkAssistant.swift
//  MybkMobile
//
//  Created by DucTran on 15/03/2023.
//

import Foundation

public func getRequest(url urlString: String, completion: @escaping (Data?,URLResponse?, Error?) -> Void) {
    guard let url = URL(string: urlString) else {
        return
    }
    URLSession.shared.dataTask(with: url) { (data,response,error) in
        completion(data, response, error)
    }.resume()
}
