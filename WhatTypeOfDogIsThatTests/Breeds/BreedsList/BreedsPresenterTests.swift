//
//  BreedsPresenter.swift
//  WhatTypeOfDogIsThatTests
//
//  Created by Paul Ramsay on 15/08/2022.
//

import XCTest

class BreedsPresenterTests: XCTestCase {

    private var presenter: BreedsPresenter!
    private var mockView: MockView!
    private var mockApiClient: MockBreedsApiClient!
    private var mockCoordinatorDelegate: MockCoordinatorDelegate!
    
    override func setUpWithError() throws {
        self.mockView = MockView()
        self.mockApiClient = MockBreedsApiClient()
        self.mockCoordinatorDelegate = MockCoordinatorDelegate()
        self.presenter = BreedsPresenter(view: self.mockView,
                                         apiClient: self.mockApiClient,
                                         coordinatorDelegate: self.mockCoordinatorDelegate)
    }
    
    func testDidRequestImageList() {
        self.presenter.viewDidLoad()
        XCTAssertTrue(self.mockApiClient.didRequestImageList)
    }
    
    func testDidRequestBreedList() {
        self.presenter.viewDidLoad()
        XCTAssertTrue(self.mockApiClient.didRequestBreedsList)
    }
    
    func testDidReloadTableViewForNewData() {
        self.presenter.viewDidLoad()
        XCTAssertTrue(self.mockView.didReloadTableView)
    }
    
    func testNumberOfRows() {
        self.presenter.viewDidLoad()
        XCTAssertEqual(self.presenter.numberOfRows(), 2)
        switch self.presenter.item(for: 1) {
        case .breed(let breed):
            XCTAssertEqual(breed.breedName, "test")

        default:
            XCTFail("Wrong rowtype")
        }
    }
    
    func testDidShowErrorForBreedListNetworkFailure() {
        self.mockApiClient.getBreedsListStubbed = nil
        self.presenter.viewDidLoad()
        XCTAssertEqual(self.presenter.numberOfRows(), 1)
        switch self.presenter.item(for: 0) {
        case .error(let title, let description):
            XCTAssertEqual(title, "Oh no, looks like a network failure")
            XCTAssertEqual(description, "Maybe try again?")

        default:
            XCTFail("Wrong rowtype")
        }
    }
    
    func testDidShowErrorForImageListNetworkFailure() {
        self.mockApiClient.getBreedImageListStubbed = nil
        self.presenter.viewDidLoad()
        XCTAssertEqual(self.presenter.numberOfRows(), 1)
        switch self.presenter.item(for: 0) {
        case .error(let title, let description):
            XCTAssertEqual(title, "Oh no, looks like a network failure")
            XCTAssertEqual(description, "Maybe try again?")

        default:
            XCTFail("Wrong rowtype")
        }
    }
}

// MARK: - MockView

private class MockView: BreedsView {
    
    var didReloadTableView = false
    var didAddViewFavouriteButton = false
    
    func reloadTableView() {
        self.didReloadTableView = true
    }
    
    func addViewFavouritesButton() {
        self.didAddViewFavouriteButton = true
    }
}

// MARK: - MockCoordinatorDelegate

private class MockCoordinatorDelegate: BreedsPresenterDelegate {
    
    var didTapViewMore = false
    
    func presenter(_ presenter: BreedsPresenter,
                   didTapBreed breed: Breed) {
        self.didTapViewMore = true
    }
    
    func presenter(_ presenter: BreedsPresenter, tappedToViewFavouritesWith breedsList: [Breed]) {
        // not needed,
    }
}

