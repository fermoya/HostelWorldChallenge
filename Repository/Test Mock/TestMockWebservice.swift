//
//  TestMockWebservice.swift
//  Repository
//
//  Created by Fernando Moya de Rivas on 30/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Domain

class TestMockWebservice: DataStore {
    
    private let propertiesResponseJSON = "mockPropertiesResponse.json"
    private let propertyDetailResponseJSON = "mockPropertyDetail_32849.json"
    
    func fetchProperties(completion: @escaping (PropertiesResponse) -> Void) {
        
        let resource = String(propertiesResponseJSON.split(separator: ".")[0])
        let ext = String(propertiesResponseJSON.split(separator: ".")[1])
        
        let url = Bundle(for: type(of: self)).url(forResource: resource,
                                        withExtension: ext)
        let data = try! Data(contentsOf: url!)
        let properties = try! JSONDecoder().decode(PropertiesWrapper.self, from: data).properties
        completion(.success(properties))
    }
    
    func fetchPropertyDetail(of id: String, completion: @escaping (PropertyDetailResponse) -> Void) {
        let resource = String(propertyDetailResponseJSON.split(separator: ".")[0])
        let ext = String(propertyDetailResponseJSON.split(separator: ".")[1])
        
        let url = Bundle(for: type(of: self)).url(forResource: resource,
                                                  withExtension: ext)
        let data = try! Data(contentsOf: url!)
        let property = try! JSONDecoder().decode(Property.self, from: data)
        completion(.success(property))
    }
    
    
}
