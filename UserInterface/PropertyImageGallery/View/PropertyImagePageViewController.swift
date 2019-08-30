//
//  PropertyImagePageViewController.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 30/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Kingfisher

class PropertyImagePageViewController: UIViewController {
    
    private var imageUrl: URL?
    private let imageView: UIImageView
    
    init(imageUrl: URL) {
        self.imageView = UIImageView()
        self.imageUrl = imageUrl
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        if let url = imageUrl {
            imageView.kf.setImage(with: url)
        }
        
        imageView.backgroundColor = Colors.ImageDefaultBackgroundColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        
        let constraints = [
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ]
        
        view.addConstraints(constraints)
    }
    
}
