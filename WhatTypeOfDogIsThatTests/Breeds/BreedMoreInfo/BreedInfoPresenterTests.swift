//
//  BreedInfoPresenterTests.swift
//  WhatTypeOfDogIsThatTests
//
//  Created by Paul Ramsay on 17/08/2022.
//

import Foundation
import XCTest

class BreedInfoPresenterTests: XCTestCase {
    
    private var presenter: BreedMoreInformationPresenter!
    private var mockView: MockView!
    private var mockFavourites: MockFavourite!
    
    override func setUpWithError() throws {
        self.mockView = MockView()
        self.mockFavourites = MockFavourite()
        let mockBreed = Breed(breedName: "Test breed title",
                              breedImageList: ["https://www.test.com"],
                              subBreeds: ["test sub-breed"])
        self.presenter = BreedMoreInformationPresenter(view: self.mockView,
                                                       favourite: self.mockFavourites,
                                                       breed: mockBreed)
    }
    
    func testTitleWasSetForNavigation() {
        self.presenter.viewDidLoad()
        XCTAssertEqual(self.presenter.title(), "Test breed title")
    }
    
    func testNumberOfSectionsForOneSubBreed() {
        self.presenter.viewDidLoad()
        XCTAssertEqual(self.presenter.numberOfSections(), 3)
    }
    
    func testNumberOfSectionsForNoSubBreeds() {
        let mockBreed = Breed(breedName: "Test breed title",
                              breedImageList: ["https://www.test.com"],
                              subBreeds: [])
        self.presenter = BreedMoreInformationPresenter(view: self.mockView,
                                                       breed: mockBreed)
        self.presenter.viewDidLoad()
        XCTAssertEqual(self.presenter.numberOfSections(), 2)
    }
    
    func testNumberOfSectionsForNoSubBreedsAndNoImages() {
        let mockBreed = Breed(breedName: "Test breed title",
                              breedImageList: [],
                              subBreeds: [])
        self.presenter = BreedMoreInformationPresenter(view: self.mockView,
                                                       breed: mockBreed)
        self.presenter.viewDidLoad()
        XCTAssertEqual(self.presenter.numberOfSections(), 1)
    }
    
    func testTitleForSubBreedSection() {
        self.presenter.viewDidLoad()
        XCTAssertEqual(self.presenter.titleFor(section: 1), "SubBreeds")
    }
    
    func testTitleForFavouritesSection() {
        self.presenter.viewDidLoad()
        XCTAssertEqual(self.presenter.titleFor(section: 0), "Favourite")
    }
    
    func testDidTapFavourite() {
        self.presenter.didTapFavourite(favourited: true)
        XCTAssertEqual(self.mockFavourites.favouritedBreed, "Test breed title")
    }
    
    func testDidTapRemoveFavourite() {
        self.presenter.didTapFavourite(favourited: false)
        XCTAssertTrue(self.mockFavourites.didTapRemoveBreed)
    }
}

// MARK: - MockView

private class MockView: BreedMoreInformationView {
    
    var didReloadTableView = false
    
    func reloadTableView() {
        self.didReloadTableView = true
    }
}

