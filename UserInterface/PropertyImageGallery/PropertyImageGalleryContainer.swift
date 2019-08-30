//
//  PropertyImageGalleryContainer.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 30/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Domain

protocol PropertyImageGalleryProvider {
    func imageGallery(for property: Property) -> PropertyGalleryPagerViewController
}

protocol PropertyImageGalleryPageProvider {
    func imageGalleryPage(with imageUrl: URL) -> PropertyImagePageViewController
}

final class PropertyImageGalleryContainer {
    
    func viewModel(for property: Property) -> PropertyGalleryPagerViewModel {
        return PropertyGalleryPagerViewModel(property: property, pageViewControllerProvider: self)
    }
    
    var navigator: PropertyImageGalleryNavigator {
        return PropertyImageGalleryNavigator(imageGalleryProvider: self)
    }
    
}

extension PropertyImageGalleryContainer: PropertyImageGalleryProvider {
    
    func imageGallery(for property: Property) -> PropertyGalleryPagerViewController {
        let galleryViewModel = viewModel(for: property)
        let galleryViewController = PropertyGalleryPagerViewController(viewModel: galleryViewModel)
        return galleryViewController
    }
    
}

extension PropertyImageGalleryContainer: PropertyImageGalleryPageProvider {
    
    func imageGalleryPage(with imageUrl: URL) -> PropertyImagePageViewController {
        return PropertyImagePageViewController(imageUrl: imageUrl)
    }
    
}
