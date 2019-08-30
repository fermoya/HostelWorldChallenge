//
//  PropertyDetailViewController.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 30/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit
import Domain

class PropertyDetailViewController: UIViewController, Bindable {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var directionsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emptyStateView: EmptyStateView!
    @IBOutlet weak var galleryContainer: UIView! {
        didSet {
            galleryContainer.backgroundColor = Colors.ImageDefaultBackgroundColor
        }
    }
    @IBOutlet weak var nextImageButtonWrapper: UIView! {
        didSet {
            nextImageButtonWrapper.layer.cornerRadius = 5
            nextImageButtonWrapper.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var previousImageButtonWrapper: UIView! {
        didSet {
            previousImageButtonWrapper.layer.cornerRadius = 5
            previousImageButtonWrapper.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var nextImageButton: UIButton! {
        didSet {
            nextImageButton.setImage(arrowImage, for: .normal)
            nextImageButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
    }
    
    @IBOutlet weak var previousImageButton: UIButton! {
        didSet {
            previousImageButton.setImage(arrowImage, for: .normal)
        }
    }
    
    private var arrowImage: UIImage? {
        return UIImage(named: "icon-arrow", in: Bundle(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
    }
    
    var viewModel: PropertyDetailViewModel
    
    init(viewModel: PropertyDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        activityIndicator.startAnimating()
        viewModel.fetchPropertyDetail()
    }
    
    func bindViewModel() {
        viewModel.didObservePropertyDetail = { [weak self] property in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.emptyStateView.isHidden = true
            self.updateUI(property: property)
        }
        
        viewModel.didObservePropertyDetailError = { [weak self] error in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.emptyStateView.isHidden = false
            self.emptyStateView.text = error.localizedDescription
        }
        
        viewModel.didObserveNewPage = { [weak self] currentPage, totalPages in
            guard let self = self else { return }
            self.updateArrowsUI(isLeftEnabled: currentPage != 0,
                                isRightEnabled: currentPage != totalPages - 1)
        }
        
        viewModel.galleryContainerDataSource = self
        
        emptyStateView.didTap = { [weak self] in
            self?.activityIndicator.startAnimating()
            self?.viewModel.fetchPropertyDetail()
        }
    }
    
    private func updateArrowsUI(isLeftEnabled: Bool, isRightEnabled: Bool) {
        nextImageButton.isUserInteractionEnabled = isRightEnabled
        previousImageButton.isUserInteractionEnabled = isLeftEnabled
        
        previousImageButton.tintColor = isLeftEnabled ? Colors.ArrowEnabledTintColor : Colors.ArrowDisabledTintColor
        nextImageButton.tintColor = isRightEnabled ? Colors.ArrowEnabledTintColor : Colors.ArrowDisabledTintColor
    }
    
    private func updateUI(property: Property) {        
        addressLabel.text = "\(property.address)"
        descriptionLabel.text = property.description
        directionsLabel.text = property.directions
        nameLabel.text = property.name
        
        updateArrowsUI(isLeftEnabled: false, isRightEnabled: true)
    }
    
    @IBAction func userDidTapPreviousImage(_ sender: UIButton) {
        viewModel.userDidTapPreviousImageButton()
    }
    
    @IBAction func userDidTapNextImage(_ sender: UIButton) {
        viewModel.userDidTapNextImageButton()
    }

}

extension PropertyDetailViewController: GalleryContainerDataSource {
    var containerView: UIView! {
        return galleryContainer
    }
    
    var containerParent: UIViewController! {
        return self
    }
}
