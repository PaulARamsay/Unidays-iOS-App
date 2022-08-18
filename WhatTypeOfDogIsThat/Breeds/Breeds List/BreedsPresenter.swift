//
//  BreedsPresenter.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 15/08/2022.
//

import Foundation

protocol BreedsView: AnyObject {
    func reloadTableView()
    func addViewFavouritesButton() 
}

protocol BreedsViewPresenting: AnyObject {
    func numberOfRows() -> Int
    func item(for row: Int) -> BreedsPresenter.RowItem
    func didSelectItem(at row: Int)
    func viewDidLoad()
    func viewWillAppear()

    var title: String { get }
    func didTapViewFavourites()
}


protocol BreedsPresenterDelegate: AnyObject {
    func presenter(_ presenter: BreedsPresenter,
                   didTapBreed breed: Breed)
    func presenter(_ presenter: BreedsPresenter,
                   tappedToViewFavouritesWith breedsList: [Breed])
}

class BreedsPresenter {
    
    private weak var view: BreedsView?
    private var apiClient: BreedsClient
    private var coordinatorDelegate: BreedsPresenterDelegate?
    
    var breeds: [Breed] = []
    var rows: [RowItem] = []
    
    enum RowItem {
        case header(title: String,
                    description: String)
        case breed(breed: Breed)
        case error(title: String,
                   descrpition: String)
    }
    
    // MARK: - Initialiser
    
    init(view: BreedsView,
         apiClient: BreedsClient = BreedsApiClient(),
         coordinatorDelegate: BreedsPresenterDelegate) {
        self.view = view
        self.apiClient = apiClient
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    func downloadBreedImageList(breedsList: [BreedData]) {
        var breedsList = breedsList
        let breed = breedsList.popLast()
        
        guard let breed = breed else {
            self.setupViewModel()
            return
        }
        
        self.apiClient.getBreedImageList(breedName: breed.breedName) { images in
            guard let images = images else {
                self.setupViewForNetworkFailure()
                return
            }
            
            self.breeds.append(.init(breedName: breed.breedName,
                                     breedImageList: images.imageList,
                                     subBreeds: breed.subBreeds))
            self.downloadBreedImageList(breedsList: breedsList)
        }
    }
    
    func setupViewForNetworkFailure() {
        self.rows.removeAll()
        self.rows.append(.error(title: "Oh no, looks like a network failure", descrpition: "Maybe try again?"))
        self.view?.reloadTableView()
    }
    
    func setupViewModel() {
        self.rows.removeAll()
        let breeds = self.breeds.sorted { x, y in
            x.breedName < y.breedName
        }

        self.rows.append(.header(title: "What Breed Is That?",
                                 description: "Have you ever seen a dog and thought - 'I wonder what breed that is?' Well this app is for you! Take a look through the list and see if you can spot that terrific pooch!"))
        self.rows += breeds.compactMap { .breed(breed: $0) }
        self.view?.reloadTableView()
    }
}

// MARK: - BreedsViewPresenting

extension BreedsPresenter: BreedsViewPresenting {
    
    func viewDidLoad() {
        self.rows.removeAll()
        self.view?.reloadTableView()
        self.apiClient.getBreedsList { breedsDictionary in
            guard let breedsDictionary = breedsDictionary else {
                self.setupViewForNetworkFailure()
                return
            }
            
            let breedsList = Array(breedsDictionary.breed.keys)
            
            let breedsListWithSubBreeds = breedsList.map { breedName in
                return BreedData(breedName: breedName,
                                 subBreeds: breedsDictionary.breed[breedName] ?? [])
            }
            
            self.downloadBreedImageList(breedsList: breedsListWithSubBreeds)
            self.view?.addViewFavouritesButton()
        }
    }
    
    func viewWillAppear() {
        // Not required, we only want to call this should we go back to the previous view
    }
    
    var title: String {
        "Breeds List"
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
        self.rows.count
    }
    
    func item(for row: Int) -> RowItem {
        self.rows[row]
    }
    
    func didTapViewFavourites() {
        self.coordinatorDelegate?.presenter(self,
                                            tappedToViewFavouritesWith: self.breeds)
    }
}
