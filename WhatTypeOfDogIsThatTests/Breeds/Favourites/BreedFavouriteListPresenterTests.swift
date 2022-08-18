//
//  BreedFavouriteListPresenter.swift
//  WhatTypeOfDogIsThatTests
//
//  Created by Paul Ramsay on 18/08/2022.
//

import Foundation
import XCTest

class BreedFavouriteListPresenterTests: XCTestCase {

    private var presenter: BreedFavouriteListPresenter!
    private var mockView: MockView!
    private var mockCoordinatorDelegate: MockCoordinatorDelegate!
    private var mockFavourite: MockFavourite!
    
    private var breeds: [Breed] = []
    
    override func setUpWithError() throws {
        self.mockView = MockView()
        self.mockCoordinatorDelegate = MockCoordinatorDelegate()
        self.mockFavourite = MockFavourite()
        self.breeds = [
            .init(breedName: "test breed", breedImageList: ["https://www.test.com"], subBreeds: ["test sub breed"])
        ]

        self.presenter = BreedFavouriteListPresenter(view: self.mockView,
                                                     breeds: self.breeds,
                                                     favourite: self.mockFavourite,
                                                     coordinatorDelegate: self.mockCoordinatorDelegate)
    }
    
    func testNumberOfRowsForFavourites() {
        self.presenter.viewDidLoad()
        XCTAssertEqual(self.presenter.numberOfRows(), 1)
    }
    
    func testNumberOfRowsAfterDeletingFavourite() {
        UserDefaults.standard.set(["test breed"], forKey: UserDefaults.Keys.favouriteKeys)
        self.presenter = BreedFavouriteListPresenter(view: self.mockView,
                                                     breeds: self.breeds,
                                                     favourite: UserDefaults.standard,
                                                     coordinatorDelegate: self.mockCoordinatorDelegate)
        self.presenter.viewDidLoad()
        XCTAssertEqual(self.presenter.numberOfRows(), 1)
        UserDefaults.standard.set([""], forKey: UserDefaults.Keys.favouriteKeys)
        self.presenter.viewWillAppear()
        XCTAssertEqual(self.presenter.numberOfRows(), 1)
    }
}

// MARK: - MockView

private class MockView: BreedsView {
    
    var didReloadTableView = false
    var didAddFavouriteButtonToView = false
    
    func addViewFavouritesButton() {
        self.didAddFavouriteButtonToView = true
    }

    func reloadTableView() {
        self.didReloadTableView = true
    }
}

// MARK: - MockCoordinatorDelegate

private class MockCoordinatorDelegate: BreedFavouriteListPresenterDelegate {
    
    var didTapViewFavouriteBreed = false
    
    func presenter(_ presenter: BreedFavouriteListPresenter, didTapBreed breed: Breed) {
        self.didTapViewFavouriteBreed = true
    }
}

