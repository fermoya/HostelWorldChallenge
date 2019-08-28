//
//  RepositoryContainer.swift
//  Repository
//
//  Created by Fernando Moya de Rivas on 28/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation

public final class RepositoryContainer {
    
    public var dataStore: DataStore { return HostelWorldMockWebservice() }
    
}
