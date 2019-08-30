//
//  AppContainer.swift
//  HostelWorldChallenge
//
//  Created by Fernando Moya de Rivas on 29/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import UIKit
import UserInterface
import Repository

final class AppContainer {
    
    let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    let navigationController: UINavigationController = UINavigationController()
    
    private lazy var userInterfaceContainer = UserInterfaceContainer(navigationController: navigationController, repositoryContainer: repositoryContainer)
    private let repositoryContainer: RepositoryContainer
    
    init() {
        let options: RepositoryType = CommandLine.arguments.contains(LaunchArguments.UITesting) ? .test : .default
        repositoryContainer = RepositoryContainer(options: options)
    }
    
    var rootViewController: UIViewController {
        let viewController = userInterfaceContainer.initialViewController
        navigationController.viewControllers = [viewController]
        return navigationController
    }
    
}
