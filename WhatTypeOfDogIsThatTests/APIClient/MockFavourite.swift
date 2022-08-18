//
//  MockFavourite.swift
//  WhatTypeOfDogIsThatTests
//
//  Created by Paul Ramsay on 18/08/2022.
//

import Foundation

class MockFavourite: Favourited {
    
    var didRequestFavouriteBreeds = false
    var favouritedBreed: String?
    var didTapRemoveBreed = false
    var didCheckBreedWasFavourited = false
    
    func favouriteBreeds() -> [String] {
        self.didRequestFavouriteBreeds = true
        return ["test breed"]
    }
    
    func addFavouriteBreed(breedName: String) {
        self.favouritedBreed = breedName
    }
    
    func removeFavouriteBreed(breedName: String) {
        self.didTapRemoveBreed = true
    }
    
    func breedIsFavourited(breedName: String) -> Bool {
        self.didCheckBreedWasFavourited = true
        return true
    }
}
