//
//  PropertyDetailNavigator.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 30/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Domain

class PropertyDetailNavigator {
    
    private let navigationController: UINavigationController
    private let viewControllerProvider: PropertyDetailViewControllerProvider
    
    init(navigationController: UINavigationController, viewControllerProvider: PropertyDetailViewControllerProvider) {
        self.navigationController = navigationController
        self.viewControllerProvider = viewControllerProvider
    }
    
    func navigateToDetail(of property: PropertySummary) {
        let viewController = viewControllerProvider.viewController(for: property)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
