//
//  RemoteProfile.swift
//  MybkMobile
//
//  Created by DucTran on 01/04/2023.
//

import Foundation

final class RemoteProfile {
    
    public static let shared: RemoteProfile = .init()
    
    public func getProfile(completion: @escaping (Result<ProfileRemoteData, Error>) -> Void) {
        guard let token = SSOServiceManager.shared.getMyBKToken() else { return }
        var requestBodyComponent = URLComponents()
        requestBodyComponent.queryItems = [URLQueryItem(name: "_token", value: token)]
        postRequest(url: Constant.Network.MYBK_PROFILE,
                    body: requestBodyComponent ) { result in
            switch result {
            case .success((let data, _)):
                do {
                    let  profile = try JSONDecoder().decode(ProfileRemoteData.self, from: data)
                    completion(.success(profile))
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
