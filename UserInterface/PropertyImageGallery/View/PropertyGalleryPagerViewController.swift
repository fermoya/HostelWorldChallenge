//
//  PropertyImageGalleryPageViewController.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 30/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

protocol PropertyGalleryPager: class {
    @discardableResult func moveToNextImage() -> Bool
    @discardableResult func moveToPreviousImage() -> Bool
    
    var currentPage: Int { get }
    var numberOfPages: Int { get }
}

class PropertyGalleryPagerViewController: UIPageViewController, Bindable {
    
    let viewModel: PropertyGalleryPagerViewModel
    
    init(viewModel: PropertyGalleryPagerViewModel) {
        self.viewModel = viewModel
        super.init(transitionStyle: .scroll,
                   navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        if let currentPage = viewModel.currentPage {
            setViewControllers([currentPage],
                               direction: .forward,
                               animated: true)
        }
    }
    
    func bindViewModel() {
        dataSource = viewModel
    }
    
}

extension PropertyGalleryPagerViewController: PropertyGalleryPager {
    var numberOfPages: Int {
        return viewModel.numberOfPages
    }
    
    var currentPage: Int {
        return viewModel.pageIndex
    }
    
    @discardableResult
    func moveToNextImage() -> Bool {
        guard let nextPage = viewModel.nextPage else { return false }
        setViewControllers([nextPage],
                           direction: .forward,
                           animated: true)
        
        return true
    }
    
    @discardableResult
    func moveToPreviousImage() -> Bool {
        guard let nextPage = viewModel.previousPage else { return false }
        setViewControllers([nextPage],
                           direction: .reverse,
                           animated: true)
        return true
    }
}
