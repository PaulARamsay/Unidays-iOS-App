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
    
    func userTappedView(breed: Breed) {
        let view = BreedMoreInformationViewController()
        let presenter = BreedMoreInformationPresenter(view: view, breed: breed)
        view.presenter = presenter
        self.navigationController.pushViewController(view, animated: true)
    }
}

// MARK: - BreedsPresenterDelegate

extension BreedListCoordinator: BreedsPresenterDelegate {
    
    func presenter(_ presenter: BreedsPresenter, didTapBreed breed: Breed) {
        self.userTappedView(breed: breed)
    }
    
    func presenter(_ presenter: BreedsPresenter, tappedToViewFavouritesWith breedsList: [Breed]) {
        let breedsView = BreedsViewController()
        let presenter = BreedFavouriteListPresenter(view: breedsView,
                                                    breeds: breedsList,
                                                    coordinatorDelegate: self)
        breedsView.presenter = presenter
        self.navigationController.pushViewController(breedsView,
                                                     animated: true)
    }

}

// MARK: - BreedFavouriteListPresenter

extension BreedListCoordinator: BreedFavouriteListPresenterDelegate {
    
    func presenter(_ presenter: BreedFavouriteListPresenter, didTapBreed breed: Breed) {
        self.userTappedView(breed: breed)
    }

}
