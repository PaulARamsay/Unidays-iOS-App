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
    
    private var rows: [BreedsPresenter.RowItem] = []
    
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
        self.rows.removeAll()
        self.favouriteList = favourites.favouriteBreeds()
        
        self.breeds = self.breeds.filter { self.favouriteList.contains($0.breedName) }
        self.rows += self.breeds.compactMap { .breed(breed: $0) }
        
        guard !self.rows.isEmpty else {
            self.rows.append(.header(title: "No Favourites",
                                     description: "You haven't selected any favourites or you are having network issues :("))
            self.view?.reloadTableView()
            return
        }
        
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
        switch self.rows[row] {
        case .breed(let breed):
            self.coordinatorDelegate?.presenter(self, didTapBreed: breed)
            
        default:
            return
            
        }
    }
    
    func numberOfRows() -> Int {
        return self.rows.count
    }
    
    func item(for row: Int) -> BreedsPresenter.RowItem {
        return self.rows[row]
    }
    
    func didTapViewFavourites() {
        // Not required - This is a shared protocol by the view
    }
}

