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

public func getRequest(with urlString: String,
                       completion: @escaping (Result<(Data,URLResponse), Error>) -> Void) {
    guard let url = URL(string: urlString) else {
        return
    }
    URLSession.shared.dataTask(with: url) { (data,response,error) in
        if let error = error {
            completion(.failure(error))
        } else {
            if let data = data,
               let response = response{
                completion(.success((data,response)))
            }
        }
    }.resume()
}

public func postRequest(url urlString: String,
                        header requestHeader: [String: String]? = nil,
                        body bodyComponent:URLComponents? = nil,
                        completion: @escaping (Result<(Data,URLResponse), Error>) -> Void) {
    guard let url = URL(string: urlString) else {
        return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = requestHeader
    request.httpBody = bodyComponent?.query?.data(using: .utf8)
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            completion(.failure(error))
        } else {
            guard let data = data,
                  let response = response else { return }
            completion(.success((data, response)))
        }
    }.resume()
}
