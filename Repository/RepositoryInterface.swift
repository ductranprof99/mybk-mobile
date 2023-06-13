//
//  RepositoryInterface.swift
//  MybkMobile
//
//  Created by DucTran on 28/05/2023.
//

import Foundation

enum UpdateState {
    case success
    case failure
}

protocol RepositoryInterface {
    func updateFromRemote(completion: @escaping (UpdateState) -> Void)
    func syncToLocal()
    func getFromLocal()
}
