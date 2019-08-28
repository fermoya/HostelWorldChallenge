//
//  HostelWorldEndpoint.swift
//  Repository
//
//  Created by Fernando Moya de Rivas on 28/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation

enum HostelWorldEndpoint {
    
    case properties(Int)
    case propertyDetail(String)
    
    private var host: String { return "https://private-anon-67a3e0bafe-practical3.apiary-mock.com" }
    
    private var path: String {
        switch self {
        case .properties(let cityId):
            return "/cities/\(cityId)/properties/"
        case .propertyDetail(let propertyId):
            return "/properties/\(propertyId)"
        }
    }
    
    var url: String { return host + path }
    
}
