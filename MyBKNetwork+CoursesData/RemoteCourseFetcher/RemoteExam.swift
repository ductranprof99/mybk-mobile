//
//  RemoteExam.swift
//  MybkMobile
//
//  Created by DucTran on 25/03/2023.
//

import Foundation

final class RemoteExam {
    
    public static let shared: RemoteExam = .init()
    
    // this private struct just for faster decode
    private struct SemeterExamDataWrapper: Decodable {
        var lichthi: [SemeterExamModel]
        
        enum CodingKeys: String, CodingKey {
            case lichthi
        }
    }

    public func getExams(token: String,
                         completion: @escaping (Result<[SemeterExamModel], Error>) -> Void) {
        var requestBodyComponent = URLComponents()
        requestBodyComponent.queryItems = [URLQueryItem(name: "_token", value: token)]
        postRequest(url: "https://mybk.hcmut.edu.vn/stinfo/lichthi/ajax_lichthi",
                    body: requestBodyComponent ) { result in
            switch result {
            case .success((let data, _)):
                do {
                    let decoder = JSONDecoder()
                    let semeterExamDataWrapper = try decoder.decode(SemeterExamDataWrapper.self, from: data)
                    let examList = semeterExamDataWrapper.lichthi
                    completion(.success(examList))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }

}
