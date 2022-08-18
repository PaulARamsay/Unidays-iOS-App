//
//  BreedMoreInformationPresenter.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 17/08/2022.
//

import Foundation

protocol BreedMoreInformationPresenting: AnyObject {
    func title() -> String
    func viewDidLoad()
    func item(for section: Int, row: Int) -> BreedMoreInformationPresenter.SectionItem.RowItem
    func numberOfSections() -> Int
    func titleFor(section: Int) -> String
    func numberOfRows(in section: Int) -> Int
    func didTapFavourite(favourited: Bool)
}

class BreedMoreInformationPresenter {
    
    struct SectionItem {
        var title: String
        var rows: [RowItem]
        
        enum RowItem {
            case subBreed(breedName: String)
            case image(imageName: String)
            case favouriteButton(favourited: Bool)
        }
    }
    
    private weak var view: BreedMoreInformationView?
    private var breed: Breed
    private var sections: [SectionItem] = []
    private let favourites: Favourited
    
    init(view: BreedMoreInformationView,
         favourite: Favourited = UserDefaults.standard,
         breed: Breed) {
        self.view = view
        self.favourites = favourite
        self.breed = breed
    }
    
    private func setupSections() {
        let breedFavourited = self.favourites.breedIsFavourited(breedName: self.breed.breedName)
        self.sections.append(.init(title: "Favourite",
                                   rows: [.favouriteButton(favourited: breedFavourited)]))
        
        let rowItems = self.breed.subBreeds.compactMap {
            SectionItem.RowItem.subBreed(breedName: $0)
        }
        
        if !rowItems.isEmpty {
            self.sections.append(SectionItem(title: "SubBreeds", rows: rowItems))
        }
        
        let imageSection = self.breed.breedImageList.compactMap {
            SectionItem(title: "",
                        rows: [SectionItem.RowItem.image(imageName: $0)])
        }
        
        self.sections += imageSection
        
        self.view?.reloadTableView()
    }
}

extension BreedMoreInformationPresenter: BreedMoreInformationPresenting {
    
    func didTapFavourite(favourited: Bool) {
        if favourited {
            self.favourites.addFavouriteBreed(breedName: self.breed.breedName)
        } else {
            self.favourites.removeFavouriteBreed(breedName: self.breed.breedName)
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        self.sections[section].rows.count
    }
    
    func item(for section: Int, row: Int) -> SectionItem.RowItem {
        self.sections[section].rows[row]
    }
    
    func numberOfSections() -> Int {
        self.sections.count
    }
    
    func titleFor(section: Int) -> String {
        self.sections[section].title
    }
    
    func viewDidLoad() {
        self.setupSections()
    }
    
    func title() -> String {
        self.breed.breedName
    }
}
