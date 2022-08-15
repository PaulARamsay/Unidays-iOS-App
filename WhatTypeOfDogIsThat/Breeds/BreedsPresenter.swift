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

protocol BreedsPresenterDelegate: AnyObject {
    func presenter(_ presenter: BreedsPresenter,
                   didTapBreedWithName name: String)
}

class BreedsPresenter {
    
    private weak var view: BreedsView?
    private var apiClient: BreedsClient
    private var coordinatorDelegate: BreedsPresenterDelegate?
    
    var breeds: [String] = []
    
    // MARK: - Initialiser
    
    init(view: BreedsView,
         apiClient: BreedsClient = BreedsApiClient(),
         coordinatorDelegate: BreedsPresenterDelegate) {
        self.view = view
        self.apiClient = apiClient
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    func viewDidLoad() {
        self.apiClient.getBreedsList { breeds in
            self.breeds = Array(breeds.breed.keys)
            self.view?.reloadTableView()
        }
    }
}

// MARK: - BreedsViewPresenting

extension BreedsPresenter: BreedsViewPresenting {
    
    func didSelectItem(at row: Int) {
        self.coordinatorDelegate?.presenter(self, didTapBreedWithName: self.breeds[row])
    }
    
    func numberOfRows() -> Int {
        return self.breeds.count
    }
    
    func item(for row: Int) -> String {
        return self.breeds[row]
    }
}
