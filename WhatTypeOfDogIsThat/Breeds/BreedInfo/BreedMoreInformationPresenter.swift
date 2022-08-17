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
}

class BreedMoreInformationPresenter {
    
    struct SectionItem {
        var title: String
        var rows: [RowItem]
        
        enum RowItem {
            case subBreed(breedName: String)
            case image(imageName: String)
        }
    }
    
    private weak var view: BreedMoreInformationView?
    private var breed: Breed
    private var sections: [SectionItem] = []
    
    init(view: BreedMoreInformationView,
         breed: Breed) {
        self.view = view
        self.breed = breed
    }
    
    private func setupSections() {
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
