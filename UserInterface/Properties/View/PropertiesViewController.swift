//
//  PropertiesViewController.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 29/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit
import Domain

class PropertiesViewController: UIViewController, Bindable {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyStateView: EmptyStateView! {
        didSet {
            emptyStateView.textColor = Colors.ErrorTextColor
        }
    }
    @IBOutlet weak var propertiesTableView: UITableView! {
        didSet {
            propertiesTableView.dataSource = self
            propertiesTableView.delegate = self
            propertiesTableView.register(UINib(nibName: PropertyCellTableViewCell.className,
                                               bundle: Bundle(for: type(of: self))),
                                         forCellReuseIdentifier: PropertyCellTableViewCell.className)
            propertiesTableView.accessibilityIdentifier = "propertiesTableView"
        }
    }
    
    var viewModel: PropertiesViewModel
    private var properties: [PropertySummary] = []
    
    init(viewModel: PropertiesViewModel) {
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
        viewModel.fetchProperties()
        title = "Gothenburg (Sweeden)"
    }
    
    func bindViewModel() {
        viewModel.didObserveProperties = { [weak self] properties in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.properties = properties
            self.emptyStateView.isHidden = true
            self.propertiesTableView.isHidden = false
            self.propertiesTableView.reloadData()
        }
        
        viewModel.didObservePropertiesError = { [weak self] error in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.propertiesTableView.isHidden = true
            self.emptyStateView.isHidden = false
            self.emptyStateView.text = error.localizedDescription
        }
        
        emptyStateView.didTap = { [weak self] in
            self?.activityIndicator.startAnimating()
            self?.viewModel.fetchProperties()
        }
    }

}

extension PropertiesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyCellTableViewCell.className) as! PropertyCellTableViewCell
        cell.property = properties[indexPath.row]
        cell.accessibilityIdentifier = "\(PropertyCellTableViewCell.className)_\(indexPath.row)"
        return cell
    }
    
    
}

extension PropertiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.userDidTap(property: properties[indexPath.row])
    }
}
