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

    private lazy var breedListCoordinator: Coordinator = {
        return BreedListCoordinator(navigationController: self.navigationController)
    }()
    
    init(navigationController: UINavigationController,
         window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }

    func start() {
        let coordinator = self.breedListCoordinator
        coordinator.start()
        let view = BreedsViewController()
        let presenter = BreedsPresenter(view: view)
        view.presenter = presenter
        self.window.rootViewController = UINavigationController(rootViewController: view)
        self.window.makeKeyAndVisible()
    }
}
