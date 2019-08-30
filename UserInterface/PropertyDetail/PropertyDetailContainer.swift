//
//  PropertyDetailContainer.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 30/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Repository
import Domain

protocol PropertyDetailViewControllerProvider {
    func viewController(for propertySummary: PropertySummary) -> UIViewController
}

class PropertyDetailContainer {
    
    private let repositoryContainer: RepositoryContainer
    private let navigationController: UINavigationController
    private let imageGalleryContainer: PropertyImageGalleryContainer
    
    init(navigationController: UINavigationController, imageGalleryContainer: PropertyImageGalleryContainer, repositoryContainer: RepositoryContainer) {
        self.navigationController = navigationController
        self.repositoryContainer = repositoryContainer
        self.imageGalleryContainer = imageGalleryContainer
    }
    
    func viewModel(for propertySummary: PropertySummary) -> PropertyDetailViewModel {
        return PropertyDetailViewModel(property: propertySummary, dataStore: repositoryContainer.dataStore, galleryNavigator: imageGalleryContainer.navigator)
    }
    
    var navigator: PropertyDetailNavigator {
        return PropertyDetailNavigator(navigationController: navigationController, viewControllerProvider: self)
    }
    
}

extension PropertyDetailContainer: PropertyDetailViewControllerProvider {
    
    func viewController(for propertySummary: PropertySummary) -> UIViewController {
        let detailViewModel = viewModel(for: propertySummary)
        let detailViewController = PropertyDetailViewController(viewModel: detailViewModel)
        return detailViewController
    }
}
