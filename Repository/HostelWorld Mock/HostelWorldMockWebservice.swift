//
//  HostelWorldWebservice.swift
//  Repository
//
//  Created by Fernando Moya de Rivas on 28/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Domain
import Alamofire

typealias HttpDataResult = Swift.Result<Data, DataStoreError>

class HostelWorldMockWebservice: DataStore {
    
    private let mockCity = 1530
    
    func fetchProperties(completion: @escaping (PropertiesResponse) -> Void) {
        let endpoint: HostelWorldEndpoint = .properties(mockCity)
        get(from: endpoint) { result in
            let propertiesResponse = result.map({ (data) -> [PropertySummary] in
                let responseWrapper = try! JSONDecoder().decode(PropertiesWrapper.self, from: data)
                return responseWrapper.properties
            })
            
            completion(propertiesResponse)
        }
    }
    
    func fetchPropertyDetail(of id: String, completion: @escaping (PropertyDetailResponse) -> Void) {
        let endpoint: HostelWorldEndpoint = .propertyDetail(id)
        get(from: endpoint) { result in
            let propertyDetailResponse = result.map({ (data) -> Property in
                return try! JSONDecoder().decode(Property.self, from: data)
            })
            
            completion(propertyDetailResponse)
        }
    }
    
    private func get(from endpoint: HostelWorldEndpoint, completion: @escaping (HttpDataResult) -> Void) {
        request(endpoint.url)
            .responseJSON { [weak self] (dataResponse) in
                guard let self = self else { return }
                let result = self.processHttpResponse(dataResponse)
                completion(result)
        }
    }
    
    private func processHttpResponse<T>(_ dataResponse: DataResponse<T>) -> HttpDataResult {
        let error = self.findErrors(in: dataResponse)
        guard error == nil else {
            return .failure(error!)
        }
        guard let data = dataResponse.data else {
            return .failure(.unknown("Empty response"))
        }
        
        return .success(data)
    }
    
    private func findErrors<T>(in dataResponse: DataResponse<T>) -> DataStoreError? {
        guard let error = dataResponse.error else { return nil }
        
        if let httpCode = dataResponse.response?.statusCode {
            return processHttpErrorResponse(with: httpCode)
        } else {
            return .unknown(error.localizedDescription)
        }
        
    }
    
    private func processHttpErrorResponse(with code: Int) -> DataStoreError {
        let error: DataStoreError
        switch code {
        case 400:
            error = .badRequest
        case 401:
            error = .unauthorized
        case 403:
            error = .forbidden
        case 404:
            error = .notFound
        case 500:
            error = .internalServerError
        case 502:
            error = .badGateway
        case 503:
            error = .unavailable
        default:
            error = .unknown("HTTP code \(code)")
        }
        return error
    }
    
}
