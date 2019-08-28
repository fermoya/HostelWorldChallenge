//
//  DataStore.swift
//  Repository
//
//  Created by Fernando Moya de Rivas on 28/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Domain

public enum DataStoreError: Error, Equatable {
    case unknown(String)
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case internalServerError
    case badGateway
    case unavailable
}

public typealias PropertiesResponse = Result<[PropertySummary], DataStoreError>
public typealias PropertyDetailResponse = Result<Property, DataStoreError>

public protocol DataStore {
    func fetchProperties(completion: @escaping (PropertiesResponse) -> Void)
    func fetchPropertyDetail(of id: String, completion: @escaping (PropertyDetailResponse) -> Void)
}
