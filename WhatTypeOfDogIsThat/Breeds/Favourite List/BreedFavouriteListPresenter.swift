//
//  BreedFavouriteListPresenter.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 18/08/2022.
//

import Foundation

protocol BreedFavouriteListPresenterDelegate: AnyObject {
    func presenter(_ presenter: BreedFavouriteListPresenter, didTapBreed breed: Breed)
}

class BreedFavouriteListPresenter {
    
    private weak var view: BreedsView?
    private let coordinatorDelegate: BreedFavouriteListPresenterDelegate?
    private var breeds: [Breed]
    private let favourites: Favourited
    
    private var favouriteList: [String] = []
    
    // MARK: - Initialiser
    
    init(view: BreedsView,
         breeds: [Breed],
         favourite: Favourited = UserDefaults.standard,
         coordinatorDelegate: BreedFavouriteListPresenterDelegate) {
        self.view = view
        self.coordinatorDelegate = coordinatorDelegate
        self.breeds = breeds
        self.favourites = favourite
    }
    
    private func setupFavouritesList() {
        self.favouriteList = favourites.favouriteBreeds()
        self.breeds = self.breeds.filter { self.favouriteList.contains($0.breedName) }
        self.view?.reloadTableView()
    }
}

// MARK: - BreedsViewPresenting

extension BreedFavouriteListPresenter: BreedsViewPresenting {
    
    func viewDidLoad() {
        self.setupFavouritesList()
    }
    
    
    func viewWillAppear() {
        self.setupFavouritesList()
    }
    
    var title: String {
        return "Favourited"
    }
    
    func didSelectItem(at row: Int) {
        self.coordinatorDelegate?.presenter(self, didTapBreed: self.breeds[row])
    }
    
    func numberOfRows() -> Int {
        return self.breeds.count
    }
    
    func item(for row: Int) -> Breed {
        return self.breeds[row]
    }
    
    func didTapViewFavourites() {
        // Not required - This is a shared protocol by the view
    }
}

