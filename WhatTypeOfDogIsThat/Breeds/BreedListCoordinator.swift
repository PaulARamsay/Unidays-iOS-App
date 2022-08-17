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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let view = BreedsViewController()
        let presenter = BreedsPresenter(view: view, coordinatorDelegate: self)
        view.presenter = presenter
        self.navigationController.pushViewController(view, animated: false)
    }
}

// MARK: - BreedsPresenterDelegate

extension BreedListCoordinator: BreedsPresenterDelegate {
    
    func presenter(_ presenter: BreedsPresenter, didTapBreed breed: Breed) {
        let view = BreedMoreInformationViewController()
        let presenter = BreedMoreInformationPresenter(view: view, breed: breed)
        view.presenter = presenter
        self.navigationController.pushViewController(view, animated: true)
    }
}
