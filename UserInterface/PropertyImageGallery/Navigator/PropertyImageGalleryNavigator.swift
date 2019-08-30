//
//  PropertyImageGalleryNavigator.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 30/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Domain

class PropertyImageGalleryNavigator {
    
    private let imageGalleryProvider: PropertyImageGalleryProvider
    
    init(imageGalleryProvider: PropertyImageGalleryProvider) {
        self.imageGalleryProvider = imageGalleryProvider
    }
    
    func embedGallery(for property: Property,
                      in containerView: UIView,
                      with parent: UIViewController) -> PropertyGalleryPager {
        let galleryViewController = imageGalleryProvider.imageGallery(for: property)
        galleryViewController.willMove(toParent: parent)
        
        galleryViewController.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(galleryViewController.view)
        
        let constraints = [
            galleryViewController.view.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1),
            galleryViewController.view.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1),
            galleryViewController.view.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            galleryViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            galleryViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        ]
        
        containerView.addConstraints(constraints)
        
        parent.addChild(galleryViewController)
        galleryViewController.didMove(toParent: parent)
        return galleryViewController
    }
    
}
