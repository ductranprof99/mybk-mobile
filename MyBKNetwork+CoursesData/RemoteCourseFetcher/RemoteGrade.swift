//
//  RemoteGrade.swift
//  MybkMobile
//
//  Created by DucTran on 25/03/2023.
//

import Foundation

final class RemoteGrade {
    
    public static let shared: RemoteGrade = .init()
    
    // this private struct just for faster decode
    private struct SemeterGradeDataWrapper: Decodable {
        var diem: [SemeterGradeModel]
        
        enum CodingKeys: String, CodingKey {
            case diem
        }
    }

    public func getGrades(token: String,
                          completion: @escaping (Result<[SemeterGradeModel], Error>) -> Void) {
        var requestBodyComponent = URLComponents()
        requestBodyComponent.queryItems = [URLQueryItem(name: "_token", value: token)]
        postRequest(url: "https://mybk.hcmut.edu.vn/stinfo/lichthi/ajax_grade",
                    body: requestBodyComponent ) { result in
            switch result {
            case .success((let data, _)):
                do {
                    let decoder = JSONDecoder()
                    let semeterGradeDataWrapper = try decoder.decode(SemeterGradeDataWrapper.self, from: data)
                    let gradeList = semeterGradeDataWrapper.diem
                    completion(.success(gradeList))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }

}
