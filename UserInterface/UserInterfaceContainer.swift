//
//  UserInterfaceContainer.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 29/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Repository

public final class UserInterfaceContainer {
    
    private lazy var propertyImageGalleryContainer: PropertyImageGalleryContainer = PropertyImageGalleryContainer()
    private lazy var propertiesContainer = PropertiesContainer(propertyDetailContainer: propertyDetailContainer, repositoryContainer: repositoryContainer)
    private lazy var propertyDetailContainer = PropertyDetailContainer(navigationController: navigationController, imageGalleryContainer: propertyImageGalleryContainer, repositoryContainer: repositoryContainer)
    
    private let navigationController: UINavigationController
    private let repositoryContainer: RepositoryContainer
    
    public init(navigationController: UINavigationController, repositoryContainer: RepositoryContainer) {
        self.navigationController = navigationController
        self.repositoryContainer = repositoryContainer
    }
    
    public var initialViewController: UIViewController { return propertiesContainer.viewController }
    
}
