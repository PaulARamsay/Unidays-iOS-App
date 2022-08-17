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
    private var mockApiClient: MockBreedsApiClient!
    
    override func setUpWithError() throws {
        self.mockView = MockView()
        self.mockApiClient = MockBreedsApiClient()
        let mockBreed = Breed(breedName: "Test breed title",
                              breedImageList: ["https://www.test.com"],
                              subBreeds: ["test sub-breed"])
        self.presenter = BreedMoreInformationPresenter(view: self.mockView,
                                                       breed: mockBreed)
    }
    
    func testTitleWasSetForNavigation() {
        self.presenter.viewDidLoad()
        XCTAssertEqual(self.presenter.title(), "Test breed title")
    }
    
    func testNumberOfSectionsForOneSubBreed() {
        self.presenter.viewDidLoad()
        XCTAssertEqual(self.presenter.numberOfSections(), 2)
    }
    
    func testNumberOfSectionsForNoSubBreeds() {
        let mockBreed = Breed(breedName: "Test breed title",
                              breedImageList: ["https://www.test.com"],
                              subBreeds: [])
        self.presenter = BreedMoreInformationPresenter(view: self.mockView,
                                                       breed: mockBreed)
        self.presenter.viewDidLoad()
        XCTAssertEqual(self.presenter.numberOfSections(), 1)
    }
    
    func testNumberOfSectionsForNoSubBreedsAndNoImages() {
        let mockBreed = Breed(breedName: "Test breed title",
                              breedImageList: [],
                              subBreeds: [])
        self.presenter = BreedMoreInformationPresenter(view: self.mockView,
                                                       breed: mockBreed)
        self.presenter.viewDidLoad()
        XCTAssertEqual(self.presenter.numberOfSections(), 0)
    }
    
    func testTitleForSubBreedSection() {
        self.presenter.viewDidLoad()
        XCTAssertEqual(self.presenter.titleFor(section: 0), "SubBreeds")
    }
}

// MARK: - MockView

private class MockView: BreedMoreInformationView {
    
    var didReloadTableView = false
    
    func reloadTableView() {
        self.didReloadTableView = true
    }
}

