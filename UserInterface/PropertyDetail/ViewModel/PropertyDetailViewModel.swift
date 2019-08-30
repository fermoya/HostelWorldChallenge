//
//  PropertyDetailViewModel.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 30/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Domain
import Repository

protocol GalleryContainerDataSource: class {
    var containerView: UIView! { get }
    var containerParent: UIViewController! { get }
}

class PropertyDetailViewModel: ViewModel {
    
    private let propertyId: String
    private let dataStore: DataStore
    private let galleryNavigator: PropertyImageGalleryNavigator
    
    var didObservePropertyDetail: ((Property) -> Void)?
    var didObservePropertyDetailError: ((Error) -> Void)?
    var didObserveNewPage: ((Int, Int) -> Void)?
    
    weak var galleryContainerDataSource: GalleryContainerDataSource?
    weak var galleryPager: PropertyGalleryPager?
    
    init(property: PropertySummary, dataStore: DataStore, galleryNavigator: PropertyImageGalleryNavigator) {
        self.propertyId = property.id
        self.dataStore = dataStore
        self.galleryNavigator = galleryNavigator
    }
    
    func fetchPropertyDetail() {
        dataStore.fetchPropertyDetail(of: propertyId) { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let detail):
                self.didObservePropertyDetail?(detail)
                self.embedGallery(for: detail)
            case .failure(let error):
                self.didObservePropertyDetailError?(error)
            }
        }
    }
    
    func userDidTapNextImageButton() {
        guard let pager = galleryPager else { return }
        if pager.moveToNextImage() {
            didObserveNewPage?(pager.currentPage, pager.numberOfPages)
        }
        
    }
    
    func userDidTapPreviousImageButton() {
        guard let pager = galleryPager else { return }
        if pager.moveToPreviousImage() {
            didObserveNewPage?(pager.currentPage, pager.numberOfPages)
        }
    }
    
    private func embedGallery(for property: Property) {
        if let containerView = galleryContainerDataSource?.containerView
            , let parent = galleryContainerDataSource?.containerParent {
            galleryPager = galleryNavigator.embedGallery(for: property, in: containerView, with: parent)
        }
    }
    
}
