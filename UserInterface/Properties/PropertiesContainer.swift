//
//  PropertiesContainer.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 29/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Repository

final class PropertiesContainer {
    
    private let repositoryContainer: RepositoryContainer
    private let propertyDetailContainer: PropertyDetailContainer
    
    init(propertyDetailContainer: PropertyDetailContainer, repositoryContainer: RepositoryContainer) {
        self.repositoryContainer = repositoryContainer
        self.propertyDetailContainer = propertyDetailContainer
    }
    
    var viewController: UIViewController {
        return PropertiesViewController(viewModel: viewModel)
    }
    
    var viewModel: PropertiesViewModel {
        return PropertiesViewModel(dataStore: repositoryContainer.dataStore, detailNavigator: propertyDetailContainer.navigator)
    }
    
}
