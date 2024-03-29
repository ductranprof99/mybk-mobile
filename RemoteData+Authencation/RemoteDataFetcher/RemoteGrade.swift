//
//  RemoteGrade.swift
//  MybkMobile
//
//  Created by DucTran on 25/03/2023.
//

import Foundation

final class RemoteGrade {
    
    public static let shared: RemoteGrade = .init()
    
    public func getGrades(completion: @escaping (Result<[GradeRemoteData], Error>) -> Void) {
        guard let token = SSOServiceManager.shared.getMyBKToken() else { return }
        var requestBodyComponent = URLComponents()
        requestBodyComponent.queryItems = [URLQueryItem(name: "_token", value: token)]
        postRequest(url: Constant.Network.MYBK_GRADE,
                    body: requestBodyComponent ) { result in
            switch result {
            case .success((let data, _)):
                do {
                    if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        let sortedDictionary = dictionary.sorted(by: { $0.key > $1.key }).compactMap {
                            return $0.value as? [String: Any]
                        }
                        completion(.success(sortedDictionary.compactMap{ try? GradeRemoteData.init($0)}))
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }

}
