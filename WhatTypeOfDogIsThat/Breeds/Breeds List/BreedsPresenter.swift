//
//  BreedsPresenter.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 15/08/2022.
//

import Foundation

protocol BreedsView: AnyObject {
    func reloadTableView()
}

protocol BreedsViewPresenting: AnyObject {
    func numberOfRows() -> Int
    func item(for row: Int) -> Breed
    func didSelectItem(at row: Int)
    func viewDidLoad()
    
    var title: String { get }
}


protocol BreedsPresenterDelegate: AnyObject {
    func presenter(_ presenter: BreedsPresenter,
                   didTapBreed breed: Breed)
}

class BreedsPresenter {
    
    private weak var view: BreedsView?
    private var apiClient: BreedsClient
    private var coordinatorDelegate: BreedsPresenterDelegate?
    
    var breeds: [Breed] = []
    
    // MARK: - Initialiser
    
    init(view: BreedsView,
         apiClient: BreedsClient = BreedsApiClient(),
         coordinatorDelegate: BreedsPresenterDelegate) {
        self.view = view
        self.apiClient = apiClient
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    func viewDidLoad() {
        self.apiClient.getBreedsList { BreedsDictionary in
            let breedsList = Array(BreedsDictionary.breed.keys)
            
            let breedsListWithSubBreeds = breedsList.map { breedName in
                return BreedData(breedName: breedName,
                                 subBreeds: BreedsDictionary.breed[breedName] ?? [])
            }
            self.downloadBreedImageList(breedsList: breedsListWithSubBreeds)
        }
    }
    
    func downloadBreedImageList(breedsList: [BreedData]) {
        var breedsList = breedsList
        let breed = breedsList.popLast()
        
        guard let breed = breed else {
            self.view?.reloadTableView()
            return
        }
        
        self.apiClient.getBreedImageList(breedName: breed.breedName) { images in
            self.breeds.append(.init(breedName: breed.breedName,
                                     breedImageList: images.imageList,
                                     subBreeds: breed.subBreeds))
            self.downloadBreedImageList(breedsList: breedsList)
        }
        
    }
}

// MARK: - BreedsViewPresenting

extension BreedsPresenter: BreedsViewPresenting {
    
    var title: String {
        return "Breeds List"
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
}
