//
//  PropertiesViewModel.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 29/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Repository
import Domain

class PropertiesViewModel: ViewModel {
    
    private let dataStore: DataStore
    private let detailNavigator: PropertyDetailNavigator
    
    var didObserveProperties: (([PropertySummary]) -> Void)?
    var didObservePropertiesError: ((Error) -> Void)?
    
    init(dataStore: DataStore, detailNavigator: PropertyDetailNavigator) {
        self.dataStore = dataStore
        self.detailNavigator = detailNavigator
    }
    
    func fetchProperties() {
        dataStore.fetchProperties { [weak self] (response) in
            switch response {
            case .success(let properties):
                self?.didObserveProperties?(properties)
            case .failure(let error):
                self?.didObservePropertiesError?(error)
            }
        }
    }
    
    func userDidTap(property: PropertySummary) {
        detailNavigator.navigateToDetail(of: property)
    }
    
}
