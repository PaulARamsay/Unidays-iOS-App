//
//  UserDefaultTests.swift
//  WhatTypeOfDogIsThatTests
//
//  Created by Paul Ramsay on 18/08/2022.
//

import Foundation
import XCTest

class FavouriteTests: XCTestCase {
    
    private var userDefault = UserDefaults.standard
    
    func testDidAddBreed() {
        self.userDefault.set([], forKey: UserDefaults.Keys.favouriteKeys)
        XCTAssertEqual(self.userDefault.favouriteBreeds(), [])
        self.userDefault.addFavouriteBreed(breedName: "Test Entry")
        XCTAssertEqual(self.userDefault.favouriteBreeds(), ["Test Entry"])
    }
    
    func testDidRemoveBreed() {
        self.userDefault.set(["Test Entry"], forKey: UserDefaults.Keys.favouriteKeys)
        XCTAssertEqual(self.userDefault.favouriteBreeds(), ["Test Entry"])
        self.userDefault.removeFavouriteBreed(breedName: "Test Entry")
        XCTAssertEqual(self.userDefault.favouriteBreeds(), [])
    }
    
    func testRemoveBreedNotInList() {
        self.userDefault.set([], forKey: UserDefaults.Keys.favouriteKeys)
        XCTAssertEqual(self.userDefault.favouriteBreeds(), [])
        self.userDefault.removeFavouriteBreed(breedName: "Test Entry")
        XCTAssertEqual(self.userDefault.favouriteBreeds(), [])
    }
    
    func testRemoveDuplicateBreeds() {
        self.userDefault.set(["Test Entry", "Test Entry"], forKey: UserDefaults.Keys.favouriteKeys)
        XCTAssertEqual(self.userDefault.favouriteBreeds(), ["Test Entry", "Test Entry"])
        self.userDefault.removeFavouriteBreed(breedName: "Test Entry")
        XCTAssertEqual(self.userDefault.favouriteBreeds(), [])
    }
    
    func testDoesNotAddDuplicateEntry() {
        self.userDefault.set(["Test Entry"], forKey: UserDefaults.Keys.favouriteKeys)
        self.userDefault.addFavouriteBreed(breedName: "Test Entry")
        XCTAssertEqual(self.userDefault.favouriteBreeds(), ["Test Entry"])
    }
}
