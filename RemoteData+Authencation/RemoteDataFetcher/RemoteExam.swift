//
//  RemoteExam.swift
//  MybkMobile
//
//  Created by DucTran on 25/03/2023.
//

import Foundation

final class RemoteExam {
    
    public static let shared: RemoteExam = .init()
    
    public func getExams(completion: @escaping (Result<[ExamRemoteData], Error>) -> Void) {
        guard let token = SSOServiceManager.shared.getMyBKToken() else { return }
        var requestBodyComponent = URLComponents()
        requestBodyComponent.queryItems = [URLQueryItem(name: "_token", value: token)]
        postRequest(url: Constant.Network.MYBK_EXAM,
                    body: requestBodyComponent ) { result in
            switch result {
            case .success((let data, _)):
                do {
                    if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        let sortedDictionary = dictionary.sorted(by: { $0.key > $1.key }).compactMap {
                            return $0.value as? [String: Any]
                        }
                        // cast nsdictionary into nsdata
                        completion(.success(sortedDictionary.compactMap{ try? ExamRemoteData.init($0)}))
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
