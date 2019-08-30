//
//  RepositoryContainer.swift
//  Repository
//
//  Created by Fernando Moya de Rivas on 28/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation

public enum RepositoryType {
    case test
    case `default`
}

public final class RepositoryContainer {
    
    private let options: RepositoryType
    
    public var dataStore: DataStore {
        switch options {
        case .test:
            return TestMockWebservice()
        case .default:
            return HostelWorldMockWebservice()
        }
    }
    
    public init(options: RepositoryType? = nil) {
        self.options = options ?? .default
    }
    
}
