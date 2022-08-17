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
        XCTAssertEqual(self.presenter.numberOfRows(), 1)
        XCTAssertEqual(self.presenter.item(for: 0).breedName, "test")
    }
}

// MARK: - MockView

private class MockView: BreedsView {
    
    var didReloadTableView = false
    
    func reloadTableView() {
        self.didReloadTableView = true
    }
}

// MARK: - MockCoordinatorDelegate

private class MockCoordinatorDelegate: BreedsPresenterDelegate {
    
    var didTapViewMore = false
    
    func presenter(_ presenter: BreedsPresenter,
                   didTapBreed breed: Breed) {
        self.didTapViewMore = true
    }
}

