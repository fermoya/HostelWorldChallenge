//
//  PropertyGalleryPagerViewModel.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 30/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Domain

class PropertyGalleryPagerViewModel: NSObject, ViewModel {
    
    private let property: Property
    private let pageViewControllerProvider: PropertyImageGalleryPageProvider
    private(set) var pageIndex = 0
    
    var numberOfPages: Int { return imageUrls.count }
    
    private var imageUrls: [URL] {
        return property.pictures.compactMap { URL(string: $0) }
    }
    private var pageCount: Int { return imageUrls.count }
    
    init(property: Property, pageViewControllerProvider: PropertyImageGalleryPageProvider) {
        self.property = property
        self.pageViewControllerProvider = pageViewControllerProvider
    }
    
    var nextPage: PropertyImagePageViewController? {
        guard pageIndex < pageCount - 1 else { return nil }
        pageIndex += 1
        let imageUrl = imageUrls[pageIndex]
        return pageViewControllerProvider.imageGalleryPage(with: imageUrl)
    }
    
    var previousPage: PropertyImagePageViewController? {
        guard pageIndex > 0 else { return nil }
        pageIndex -= 1
        let imageUrl = imageUrls[pageIndex]
        return pageViewControllerProvider.imageGalleryPage(with: imageUrl)
    }
    
    var currentPage: PropertyImagePageViewController? {
        guard pageCount > 0 else { return nil }
        let imageUrl = imageUrls[pageIndex]
        return pageViewControllerProvider.imageGalleryPage(with: imageUrl)
    }
    
}

extension PropertyGalleryPagerViewModel: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
}
