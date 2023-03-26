//
//  RemoteSchedule.swift
//  MybkMobile
//
//  Created by DucTran on 25/03/2023.
//

import Foundation

final class RemoteSchedule {
    
    public static let shared: RemoteSchedule = .init()
    
    public func getSchedules(token: String,
                         completion: @escaping (Result<[SemeterScheduleModel], Error>) -> Void) {
        var requestBodyComponent = URLComponents()
        requestBodyComponent.queryItems = [URLQueryItem(name: "_token", value: token)]
        postRequest(url: Constant.MYBK_SCHEDULE,
                    body: requestBodyComponent ) { result in
            switch result {
            case .success((let data, _)):
                do {
                    // convert data into [SemeterScheduleModel]
                    let schedules = try JSONDecoder().decode([SemeterScheduleModel].self, from: data)
                    completion(.success(schedules))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }

}
