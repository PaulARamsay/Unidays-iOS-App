//
//  UserDefaults+Extensions.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 17/08/2022.
//

import Foundation

extension UserDefaults {
    
    enum Keys {
        static let favouriteKeys: String = "favourites"
    }
}

// MARK: - Favourited

extension UserDefaults: Favourited {}

protocol Favourited {
    func favouriteBreeds() -> [String]
    func addFavouriteBreed(breedName: String)
    func removeFavouriteBreed(breedName: String)
    func breedIsFavourited(breedName: String) -> Bool
}

extension Favourited where Self: UserDefaults {
    
    func favouriteBreeds() -> [String] {
        self.stringArray(forKey: UserDefaults.Keys.favouriteKeys) ?? []
    }
    
    func addFavouriteBreed(breedName: String) {
        var array = self.favouriteBreeds()
        
        guard !array.contains(breedName) else { return }

        array.append(breedName)
        self.set(array, forKey: UserDefaults.Keys.favouriteKeys)
    }
    
    func removeFavouriteBreed(breedName: String) {
        var array = self.favouriteBreeds()
        array.removeAll { thisBreedName in
            thisBreedName == breedName
        }

        self.set(array, forKey: UserDefaults.Keys.favouriteKeys)
    }
    
    func breedIsFavourited(breedName: String) -> Bool {
        return self.favouriteBreeds().contains { thisBreedName in
            breedName == thisBreedName
        }
    }
}
