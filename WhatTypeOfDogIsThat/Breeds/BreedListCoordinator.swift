//
//  BreedListCoordinator.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 15/08/2022.
//

import Foundation
import UIKit

class BreedListCoordinator: Coordinator {
    
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
        let presenter = BreedsPresenter(view: view, coordinatorDelegate: self)
        view.presenter = presenter
        self.window.rootViewController = UINavigationController(rootViewController: view)
        self.window.makeKeyAndVisible()
    }
}

// MARK: - BreedsPresenterDelegate

extension BreedListCoordinator: BreedsPresenterDelegate {
    
    func presenter(_ presenter: BreedsPresenter, didTapBreed breed: Breed) {
        // TODO: Link to new breed details view controller
    }
}
