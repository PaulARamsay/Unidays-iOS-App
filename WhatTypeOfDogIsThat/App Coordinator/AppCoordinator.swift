//
//  AppCoordinator.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 15/08/2022.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var window: UIWindow

    init(navigationController: UINavigationController,
         window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }

    func start() {
        let view = BreedsViewController()
        self.window.rootViewController = UINavigationController(rootViewController: view)
        self.window.makeKeyAndVisible()
    }
}
